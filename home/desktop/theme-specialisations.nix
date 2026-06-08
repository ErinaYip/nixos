{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args: let
  inherit (eriniteLib) mkModule;
  inherit (eriniteLib.themeSpecialisations) mkThemeSpecialisationOptions;
in
  mkModule args {
    namespace = ["erinite" "home"];
    category = "desktop";
    name = "theme-specialisations";

    opts = mkThemeSpecialisationOptions "Wallpapers to turn into Home Manager theme settings.";

    configFn = {cfg, ...}: let
      inherit (cfg) wallpapers;
      defaultWallpaper = wallpapers.${cfg.default};

      buildStylix = _name: wallpaper: {
        inherit (wallpaper) base16Scheme image polarity;
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

      programs.dank-material-shell.plugins.eriniteThemeSwitcher = {
        src = ./dms/plugins/EriniteThemeSwitcher;
        settings = {
          systemdEscapePath = lib.getExe' pkgs.systemd "systemd-escape";
          systemctlPath = lib.getExe' pkgs.systemd "systemctl";
          dmsPath = lib.getExe args.config.programs.dank-material-shell.package;
          restartDelayMs = 500;
        };
      };
    };
  }
