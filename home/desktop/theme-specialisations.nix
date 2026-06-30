{
  lib,
  pkgs,
  inputs,
  config,
  eriniteLib,
  isNixosHome ? false,
  ...
} @ args: let
  inherit (lib) mapAttrs;
  inherit (eriniteLib) mkModule;
in
  mkModule args {
    configFn = _: let
      inherit (config.erinite.wallpapers) wallpapers;

      buildStylix = _name: wallpaper: {
        inherit (wallpaper) base16Scheme image polarity;
      };

      buildDms = wallpaper: {
        session = {
          isLightMode = wallpaper.polarity == "light";
          wallpaperPath = wallpaper.path;
        };
        settings.matugenScheme = wallpaper.type;
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
      programs.dank-material-shell.plugins.wallpaperWatcherDaemon = {
        src = inputs.dms + "/quickshell/PLUGINS/WallpaperWatcherDaemon";
        settings.scriptPath = "${themeSwitch}/bin/erinite-theme-switch";
      };

    } // lib.optionalAttrs (!isNixosHome) {
      specialisation =
        mapAttrs (name: wallpaper: {
          configuration = {
            xdg.dataFile."home-manager/specialisation".text = name;
            stylix = buildStylix name wallpaper;
            programs.dank-material-shell = buildDms wallpaper;
          };
        })
        wallpapers;
    };
  }
