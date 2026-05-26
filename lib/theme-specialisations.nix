{
  lib,
  pkgs,
  eriniteLib,
}: let
  inherit (eriniteLib) mkStrOpt mkAttrOpt;
  inherit (lib) types mkOption escapeShellArg;

  script = ./color-scheme/matugen-to-base16.py;

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
    };
  };
in {
  mkThemeSpecialisationOptions = description: {
    default = mkStrOpt "nixos-local-dark" "Wallpaper theme name to apply to the base configuration.";
    wallpapers =
      mkAttrOpt wallpaperModule {
        nixos-local-dark = {
          polarity = "dark";
          image = pkgs.nixos-artwork.wallpapers.catppuccin-frappe.src;
        };
      }
      description;
  };

  mkThemeBase16Scheme = suffix: name: wallpaper:
    pkgs.runCommand "${name}-${suffix}base16.yaml" {
      nativeBuildInputs = with pkgs; [matugen python3];
    } ''
      python ${script} ${escapeShellArg (toString wallpaper.image)} \
        --name ${escapeShellArg name} \
        --polarity ${escapeShellArg wallpaper.polarity} \
        --output $out
    '';
}
