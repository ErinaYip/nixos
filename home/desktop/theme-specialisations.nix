{
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args: let
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
      defaultWallpaper = wallpapers.${cfg.default};

      buildStylix = name: wallpaper: {
        base16Scheme = "${mkThemeBase16Scheme "" name wallpaper}";
        inherit (wallpaper) image polarity;
      };

      themeSwitch = pkgs.writeShellApplication {
        name = "erinite-theme-switch";
        runtimeInputs = with pkgs; [coreutils systemd];
        text = ''
          set -euo pipefail

          wallpaper="''${1-}"
          file_name="$(basename -- "$wallpaper")"
          choice="''${file_name%.*}"

          unit="$(systemd-escape --template=erinite-theme-switch@.service "$choice")"
          systemctl start "$unit" & sleep 0.5 ; dms restart
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
