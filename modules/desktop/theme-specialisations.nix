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
          name = mkStrOpt "" "Specialisation and color scheme name.";
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
      wallpapers = mkListOpt wallpaperModule [] "Wallpapers to turn into theme specialisations.";
    };

    configFn = {cfg, ...}: let
      script = ../../lib/color-scheme/matugen-to-base16.py;
      defaultWallpapers = [
        {
          name = "nixos-local-dark";
          polarity = "dark";
          image = "${pkgs.nixos-artwork.wallpapers.simple-dark-gray.src}";
          matugenScheme = "scheme-tonal-spot";
          fallbackColor = null;
        }
      ];

      buildScheme = wallpaper:
        pkgs.runCommand "${wallpaper.name}-base16.yaml" {
          nativeBuildInputs = [
            pkgs.imagemagick
            pkgs.matugen
            pkgs.python3
          ];
        } ''
          python ${script} ${lib.escapeShellArg (toString wallpaper.image)} \
            --name ${lib.escapeShellArg wallpaper.name} \
            --polarity ${lib.escapeShellArg wallpaper.polarity} \
            --type ${lib.escapeShellArg wallpaper.matugenScheme} \
            ${lib.optionalString (wallpaper.fallbackColor != null) "--fallback-color ${lib.escapeShellArg wallpaper.fallbackColor}"} \
            --output $out
        '';

      buildHomeConfig = specialisationTheme: wallpaper: let
        priority =
          if specialisationTheme
          then lib.mkOverride 80
          else lib.mkOverride 90;
      in {
        stylix = {
          base16Scheme = priority "${buildScheme wallpaper}";
          image = priority wallpaper.image;
          polarity = priority wallpaper.polarity;
        };

        xdg.dataFile = {
          "erinite-theme/name".text = priority wallpaper.name;
          "erinite-theme/wallpaper".source = priority wallpaper.image;
        };
      };

      wallpapersByName = lib.foldl' (
        acc: wallpaper:
          acc
          // {
            ${wallpaper.name} = wallpaper;
          }
      ) {} (
        defaultWallpapers ++ cfg.wallpapers
      );

      defaultWallpaper =
        if cfg.default == null
        then null
        else wallpapersByName.${cfg.default};

      wallpapers = lib.attrValues wallpapersByName;
    in
      lib.mkMerge [
        {
          assertions = [
            {
              assertion = lib.all (wallpaper: wallpaper.name != "") wallpapers;
              message = "Every erinite.desktop.theme-specialisations.wallpapers entry needs a non-empty name.";
            }
            {
              assertion = cfg.default == null || builtins.hasAttr cfg.default wallpapersByName;
              message = "erinite.desktop.theme-specialisations.default must match one of the configured wallpaper names.";
            }
          ];
        }

        (lib.mkIf (defaultWallpaper != null) {
          erinite.home = buildHomeConfig false defaultWallpaper;
        })

        {
          specialisation = lib.listToAttrs (
            map (wallpaper:
              lib.nameValuePair wallpaper.name {
                configuration = {
                  erinite.home = buildHomeConfig true wallpaper;
                  environment.etc."erinite-theme/specialisation".text = wallpaper.name;
                };
              })
            wallpapers
          );
        }
      ];
  }
