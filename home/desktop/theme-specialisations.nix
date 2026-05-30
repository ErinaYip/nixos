{
  lib,
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args: let
  inherit (lib) mapAttrsToList;
  inherit (eriniteLib) mkModule;
  inherit (eriniteLib.themeSpecialisations) mkThemeBase16Scheme mkThemeSpecialisationOptions;
in
  mkModule args {
    namespace = ["erinite" "home"];
    category = "desktop";
    name = "theme-specialisations";

    opts = mkThemeSpecialisationOptions "Wallpapers to turn into Home Manager theme settings.";

    configFn = {cfg, ...}: let
      inherit (cfg) wallpapers;

      wallpaperLinks =
        mapAttrsToList
        (_: wallpaper: {
          name = wallpaper.fileName;
          path = wallpaper.image;
        })
        wallpapers;

      wallpaperDir = pkgs.linkFarm "erinite-theme-wallpapers" wallpaperLinks;
      wallpaperPath = name: "${wallpaperDir}/${wallpapers.${name}.fileName}";
      defaultWallpaper = wallpapers.${cfg.default};
      defaultWallpaperPath = wallpaperPath cfg.default;
      buildStylix = name: wallpaper: {
        base16Scheme = "${mkThemeBase16Scheme "" name wallpaper}";
        inherit (wallpaper) image polarity;
      };

      themeSwitch = pkgs.writeShellApplication {
        name = "erinite-theme-switch";
        runtimeInputs = with pkgs; [
          coreutils
          systemd
        ];
        text = ''
          set -euo pipefail

          wallpaper="''${1-}"
          file_name="$(basename -- "$wallpaper")"
          choice="''${file_name%.*}"

          unit="$(systemd-escape --template=erinite-theme-switch@.service "$choice")"
          systemctl start "$unit"
        '';
      };
    in {
      erinite.home.desktop = {
        stylix.settings = buildStylix cfg.default defaultWallpaper;
        dms = {
          session.wallpaperPath = lib.mkForce defaultWallpaperPath;
          settings.matugenScheme = defaultWallpaper.type;
        };
      };

      programs.dank-material-shell.plugins.wallpaperWatcherDaemon = {
        src = inputs.dms + "/quickshell/PLUGINS/WallpaperWatcherDaemon";
        settings.scriptPath = "${themeSwitch}/bin/erinite-theme-switch";
      };
    };
  }
