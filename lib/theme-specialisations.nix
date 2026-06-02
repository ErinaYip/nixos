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
      path = mkStrOpt null "Wallpaper path.";
      index = mkIntOpt 0 "Source color index";
      style = mkOption {
        type = types.enum ["balanced" "vivid" "soft" "analogous" "triad"];
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
        description = "matugen scheme type";
      };
      polarity = mkOption {
        type = types.enum ["dark" "light"];
        description = "Stylix polarity for this generated theme.";
      };
    };
  };

  mkWallpapers = _dir:
    lib.mapAttrs' (
      name: wallpaper: let
        fileName = wallpaper.fileName or name;
        image =
          if wallpaper ? image
          then wallpaper.image
          else
            pkgs.fetchurl {
              name = fileName;
              inherit (wallpaper) url hash;
            };
      in
        lib.nameValuePair (builtins.head (lib.splitString "." fileName)) {
          inherit fileName image;
          type = wallpaper.type or "scheme-tonal-spot";
          style = wallpaper.style or "soft";
          index = wallpaper.index or 0;
          polarity = wallpaper.polarity or "dark";
          path = "${_dir}/${fileName}";
        }
    );
in {
  mkThemes = {
    default,
    wallpapers,
  }: let
    processedWallpapers = mkWallpapers themeDir wallpapers;

    themeDir = pkgs.linkFarm "erinite-theme-wallpapers" (
      lib.mapAttrsToList (_: wp: {
        name = wp.fileName;
        path = wp.image;
      })
      processedWallpapers
    );
  in {
    inherit default;
    wallpapers = processedWallpapers;
  };

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
