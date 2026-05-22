{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    category = "desktop";
    name = "theme-specialisations";

    opts = let
      inherit (lib) types;

      wallpaperModule = types.submodule {
        options = {
          image = lib.mkOption {
            type = types.oneOf [types.path types.package types.str];
            description = "Wallpaper image used to generate this theme.";
          };
          polarity = lib.mkOption {
            type = types.enum ["dark" "light"];
            default = "dark";
            description = "Stylix polarity for this generated theme.";
          };
          matugenScheme = mkStrOpt "scheme-tonal-spot" "Matugen scheme type.";
          fallbackColor = lib.mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "Optional fallback source color for matugen.";
          };
        };
      };
    in {
      default = lib.mkOption {
        type = types.nullOr types.str;
        default = "nixos-local-dark";
        description = "Wallpaper theme name to apply to the base configuration.";
      };
      wallpapers = mkAttrOpt wallpaperModule {} "Wallpapers to turn into theme specialisations.";
    };

    configFn = {cfg, ...}: let
      script = ../../lib/color-scheme/matugen-to-base16.py;
      defaultWallpapers = {
        nixos-local-dark = {
          polarity = "dark";
          image = "${pkgs.nixos-artwork.wallpapers.simple-dark-gray.src}";
          matugenScheme = "scheme-tonal-spot";
          fallbackColor = null;
        };
      };

      buildScheme = name: wallpaper:
        pkgs.runCommand "${name}-base16.yaml" {
          nativeBuildInputs = [
            pkgs.imagemagick
            pkgs.matugen
            pkgs.python3
          ];
        } ''
          python ${script} ${lib.escapeShellArg (toString wallpaper.image)} \
            --name ${lib.escapeShellArg name} \
            --polarity ${lib.escapeShellArg wallpaper.polarity} \
            --type ${lib.escapeShellArg wallpaper.matugenScheme} \
            ${lib.optionalString (wallpaper.fallbackColor != null) "--fallback-color ${lib.escapeShellArg wallpaper.fallbackColor}"} \
            --output $out
        '';

      buildHomeConfig = specialisationTheme: name: wallpaper: let
        priority =
          if specialisationTheme
          then lib.mkOverride 80
          else lib.mkOverride 90;
      in {
        stylix = {
          base16Scheme = priority "${buildScheme name wallpaper}";
          image = priority wallpaper.image;
          polarity = priority wallpaper.polarity;
        };

        xdg.dataFile = {
          "erinite-theme/name".text = priority name;
          "erinite-theme/wallpaper".source = priority wallpaper.image;
        };
      };

      wallpapers = defaultWallpapers // cfg.wallpapers;

      defaultWallpaper =
        if cfg.default == null
        then null
        else wallpapers.${cfg.default};
    in
      lib.mkMerge [
        {
          assertions = [
            {
              assertion = cfg.default == null || builtins.hasAttr cfg.default wallpapers;
              message = "erinite.desktop.theme-specialisations.default must match one of the configured wallpaper names.";
            }
          ];
        }

        (lib.mkIf (defaultWallpaper != null) {
          erinite.home = buildHomeConfig false cfg.default defaultWallpaper;
        })

        {
          specialisation = lib.mapAttrs (name: wallpaper: {
            configuration = {
              erinite.home = buildHomeConfig true name wallpaper;
              environment.etc."erinite-theme/specialisation".text = name;
            };
          }) wallpapers;
        }
      ];
  }
