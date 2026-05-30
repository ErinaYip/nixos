{
  lib,
  pkgs,
  eriniteLib,
}: let
  inherit (eriniteLib) mkIntOpt mkStrOpt mkAttrOpt;
  inherit (lib) types mkOption escapeShellArg;

  script = ./color-scheme/matugen-to-base16.py;

  wallpaperModule = types.submodule {
    options = {
      image = mkOption {
        type = types.oneOf [types.path types.package types.str];
        description = "Wallpaper image used to generate this theme.";
      };
      fileName = mkOption {
        type = types.str;
        description = "Wallpaper file name.";
      };
      index = mkIntOpt 0 "Source color index";
      style = mkOption {
        type = types.enum ["balanced" "vivid" "soft" "analogous" "triad"];
        default = "soft";
        description = "base16 remapping style";
      };
      type = mkOption {
        type = types.enum [
          "scheme-content"
          "scheme-expressive"
          "scheme-fidelity"
          "scheme-fruit-salad"
          "scheme-monochrome"
          "scheme-neutral"
          "scheme-rainbow"
          "scheme-tonal-spot"
        ];
        default = "scheme-tonal-spot";
        description = "matugen scheme type";
      };
      polarity = mkOption {
        type = types.enum ["dark" "light"];
        default = "dark";
        description = "Stylix polarity for this generated theme.";
      };
    };
  };
in {
  mkWallpapers =
    lib.mapAttrs' (fileName: {
      url,
      hash,
      type ? "scheme-tonal-spot",
      style ? "soft",
      index ? 0,
      polarity ? "dark",
    }:
      lib.nameValuePair (builtins.head (lib.splitString "." fileName)) {
        inherit fileName type style index polarity;
        image = pkgs.fetchurl {
          name = fileName;
          inherit url hash;
        };
      });

  mkThemeSpecialisationOptions = description: {
    default = mkStrOpt "nixos-local-dark" "Wallpaper theme name to apply to the base configuration.";
    wallpapers =
      mkAttrOpt wallpaperModule {
        nixos-local-dark = {
          polarity = "dark";
          fileName = "nixos-local-dark.png";
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
        --index ${escapeShellArg wallpaper.index} \
        --style ${escapeShellArg wallpaper.style} \
        --type ${escapeShellArg wallpaper.type} \
        --output $out
    '';
}
