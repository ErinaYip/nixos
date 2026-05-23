{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args: let
  inherit (eriniteLib) mkModule mkStrOpt mkAttrOpt;
  inherit (lib) types mkOption mapAttrs escapeShellArg optionalString mkForce id;
in
  mkModule args {
    category = "desktop";
    name = "theme-specialisations";

    opts = let
      wallpaperModule = types.submodule {
        options = {
          image = mkOption {
            type = types.oneOf [types.path types.package types.str];
            description = "Wallpaper image used to generate this theme.";
          };
          polarity = mkOption {
            type = types.enum ["dark" "light"];
            default = "dark";
            description = "Stylix polarity for this generated theme.";
          };
          matugenScheme = mkStrOpt "scheme-tonal-spot" "Matugen scheme type.";
          fallbackColor = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "Optional fallback source color for matugen.";
          };
        };
      };
    in {
      default = mkStrOpt "nixos-local-dark" "Wallpaper theme name to apply to the base configuration.";
      wallpapers = mkAttrOpt wallpaperModule {} "Wallpapers to turn into theme specialisations.";
    };

    configFn = {cfg, ...}: let
      script = ../../lib/color-scheme/matugen-to-base16.py;

      wallpapers =
        {
          nixos-local-dark = {
            polarity = "dark";
            image = pkgs.nixos-artwork.wallpapers.simple-dark-gray.src;
            matugenScheme = "scheme-tonal-spot";
            fallbackColor = null;
          };
        }
        // cfg.wallpapers;

      buildScheme = name: wallpaper:
        pkgs.runCommand "${name}-base16.yaml" {
          nativeBuildInputs = with pkgs; [imagemagick matugen python3];
        } ''
          python ${script} ${escapeShellArg (toString wallpaper.image)} \
            --name ${escapeShellArg name} \
            --polarity ${escapeShellArg wallpaper.polarity} \
            --type ${escapeShellArg wallpaper.matugenScheme} \
            ${optionalString (wallpaper.fallbackColor != null) "--fallback-color ${escapeShellArg wallpaper.fallbackColor}"} \
            --output $out
        '';

      buildSystemConfig = name: wallpaper: useForce: let
        maybeForce =
          if useForce
          then mkForce
          else id;
      in {
        stylix = {
          base16Scheme = maybeForce "${buildScheme name wallpaper}";
          image = maybeForce wallpaper.image;
          polarity = maybeForce wallpaper.polarity;
        };

        environment.etc = {
          "erinite-theme/name".text = maybeForce name;
          "erinite-theme/wallpaper".source = maybeForce wallpaper.image;
        };
      };

      defaultWallpaper = wallpapers.${cfg.default};
    in {
      assertions = [
        {
          assertion = builtins.hasAttr cfg.default wallpapers;
          message = "erinite.desktop.theme-specialisations.default must match one of the configured wallpaper names.";
        }
      ];

      inherit ((buildSystemConfig cfg.default defaultWallpaper false)) stylix;
      environment.etc = (buildSystemConfig cfg.default defaultWallpaper false).environment.etc;

      specialisation =
        mapAttrs (name: wallpaper: {
          configuration = let
            forcedConfig = buildSystemConfig name wallpaper true;
          in {
            inherit (forcedConfig) stylix;
            environment.etc =
              forcedConfig.environment.etc
              // {
                "erinite-theme/specialisation".text = mkForce name;
              };
          };
        })
        wallpapers;
    };
  }
