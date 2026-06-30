{
  lib,
  pkgs,
  eriniteLib,
}: let
  inherit (eriniteLib) mkIntOpt;
  inherit (lib) types mkOption escapeShellArg;
in
  lib.makeExtensible (final: {
    script = ../lib/color-scheme/matugen-to-base16.py;

    wallpaperDefinitionModule = types.submodule {
      options = {
        url = mkOption {
          type = types.str;
          description = "Remote wallpaper URL.";
        };
        hash = mkOption {
          type = types.str;
          description = "Remote wallpaper hash.";
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

    mkBase16Scheme = suffix: name: wallpaper:
      pkgs.runCommand "${name}-${suffix}base16.yaml" {
        nativeBuildInputs = with pkgs; [matugen python3];
      } ''
        python ${final.script} ${escapeShellArg (toString wallpaper.image)} \
          --name ${escapeShellArg name} \
          --polarity ${escapeShellArg wallpaper.polarity} \
          --index ${escapeShellArg wallpaper.index} \
          --style ${escapeShellArg wallpaper.style} \
          --type ${escapeShellArg wallpaper.type} \
          --output $out
      '';

    mkWallpapers = definitions: let
      processedWallpapers =
        lib.mapAttrs' (
          fileName: wallpaper: let
            image = pkgs.fetchurl {
              name = fileName;
              inherit (wallpaper) url hash;
            };
          in
            lib.nameValuePair (builtins.head (lib.splitString "." fileName)) {
              inherit fileName image;
              inherit (wallpaper) type style index polarity;
              path = "${themeDir}/${fileName}";
            }
        )
        definitions;

      themeDir = pkgs.linkFarm "erinite-theme-wallpapers" (
        lib.mapAttrsToList (_: wp: {
          name = wp.fileName;
          path = wp.image;
        })
        processedWallpapers
      );
    in
      lib.mapAttrs
      (name: wallpaper:
        wallpaper
        // {
          base16Scheme = "${final.mkBase16Scheme "" name wallpaper}";
        })
      processedWallpapers;
  })
