{
  lib,
  pkgs,
  inputs,
  eriniteLib,
  config,
  ...
} @ args: let
  inherit (lib) mapAttrs mkForce;
  inherit (eriniteLib) mkModule;
in
  mkModule args {
    configFn = _: let
      themeName = config.erinite.wallpapers.default;
      inherit (config.erinite.wallpapers) wallpapers;
      defaultWallpaper = wallpapers.${themeName};

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
        stylix.settings = buildStylix themeName defaultWallpaper;
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

      specialisation =
        mapAttrs (name: wallpaper: {
          configuration = {
            xdg.dataFile."home-manager/specialisation".text = name;
            erinite.wallpapers.default = mkForce name;
            erinite.home.desktop = {
              stylix.settings = mapAttrs (_: mkForce) (buildStylix name wallpaper);
              dms = {
                session = {
                  isLightMode = mkForce (wallpaper.polarity == "light");
                  wallpaperPath = mkForce wallpaper.path;
                };
                settings.matugenScheme = mkForce wallpaper.type;
              };
            };
          };
        })
        wallpapers;
    };
  }
