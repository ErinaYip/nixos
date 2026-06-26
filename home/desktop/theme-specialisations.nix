{
  lib,
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args: let
  inherit (eriniteLib) mkModule;
  inherit (eriniteLib.themeSpecialisations) mkThemeSpecialisationOptions;
in
  mkModule args {
    opts = mkThemeSpecialisationOptions "Wallpapers to turn into Home Manager theme settings.";

    configFn = {cfg, ...}: let
      inherit (cfg) wallpapers;
      defaultWallpaper = wallpapers.${cfg.default};

      buildStylix = _name: wallpaper: {
        inherit (wallpaper) base16Scheme image polarity;
      };

      dmsPath = lib.getExe args.config.programs.dank-material-shell.package;
      themeSwitch = pkgs.writeShellApplication {
        name = "erinite-theme-switch";
        runtimeInputs = with pkgs; [coreutils systemd];
        text = ''
          set -euo pipefail

          wallpaper="''${1-}"
          case "$wallpaper" in
            ""|\#*) exit 0 ;;
          esac

          wallpaper="''${wallpaper#file://}"
          file_name="$(basename -- "$wallpaper")"
          choice="''${file_name%.*}"

          if [ -z "$choice" ]; then
            exit 0
          fi

          dms=${lib.escapeShellArg dmsPath}

          unit="$(systemd-escape --template=erinite-theme-switch@.service "$choice")"
          systemctl start --no-block "$unit"

          sleep 0.5
          "$dms" restart >/dev/null 2>&1 || true
        '';
      };
    in {
      erinite.home.desktop = {
        stylix.settings = buildStylix cfg.default defaultWallpaper;
        dms = {
          session = {
            isLightMode = defaultWallpaper.polarity == "light";
            wallpaperPath = defaultWallpaper.path;
          };
          settings.matugenScheme = defaultWallpaper.type;
        };
      };

      programs.dank-material-shell.plugins.wallpaperWatcherDaemon = {
        src = inputs.dms + "/quickshell/PLUGINS/WallpaperWatcherDaemon";
        settings.scriptPath = "${themeSwitch}/bin/erinite-theme-switch";
      };
    };
  }
