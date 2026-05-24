{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args: let
  inherit (eriniteLib) mkModule mkStrOpt mkAttrOpt;
  inherit (lib) types mkOption escapeShellArg optionalString;
in
  mkModule args {
    namespace = ["erinite" "home"];
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
          matugenScheme = mkStrOpt "scheme-content" "Matugen scheme type.";
          fallbackColor = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "Optional fallback source color for matugen.";
          };
        };
      };
    in {
      default = mkStrOpt "nixos-local-dark" "Wallpaper theme name to apply to the base configuration.";
      wallpapers = mkAttrOpt wallpaperModule {} "Wallpapers to turn into Home Manager theme settings.";
    };

    configFn = {cfg, ...}: let
      script = ../../lib/color-scheme/matugen-to-base16.py;

      wallpapers =
        {
          nixos-local-dark = {
            polarity = "dark";
            image = pkgs.nixos-artwork.wallpapers.catppuccin-frappe.src;
            matugenScheme = "scheme-content";
            fallbackColor = null;
          };
        }
        // cfg.wallpapers;

      buildScheme = name: wallpaper:
        pkgs.runCommand "${name}-home-base16.yaml" {
          nativeBuildInputs = with pkgs; [imagemagick matugen python3];
        } ''
          python ${script} ${escapeShellArg (toString wallpaper.image)} \
            --name ${escapeShellArg name} \
            --polarity ${escapeShellArg wallpaper.polarity} \
            --type ${escapeShellArg wallpaper.matugenScheme} \
            ${optionalString (wallpaper.fallbackColor != null) "--fallback-color ${escapeShellArg wallpaper.fallbackColor}"} \
            --output $out
        '';

      buildHomeSettings = name: wallpaper: {
        base16Scheme = "${buildScheme name wallpaper}";
        inherit (wallpaper) image polarity;
      };

      defaultWallpaper = wallpapers.${cfg.default};
    in {
      assertions = [
        {
          assertion = builtins.hasAttr cfg.default wallpapers;
          message = "erinite.home.desktop.theme-specialisations.default must match one of the configured wallpaper names.";
        }
      ];

      erinite.home.desktop.stylix.settings = buildHomeSettings cfg.default defaultWallpaper;
    };
  }
