{
  lib,
  eriniteLib,
  ...
} @ args: let
  inherit (eriniteLib) mkModule themeSpecialisations;
in
  mkModule args {
    namespace = ["erinite" "home"];
    category = "desktop";
    name = "theme-specialisations";

    opts = themeSpecialisations.mkThemeSpecialisationOptions "Wallpapers to turn into Home Manager theme settings.";

    configFn = {cfg, ...}: let
      wallpapers = themeSpecialisations.mkThemeWallpapers cfg;

      buildHomeSettings = name: wallpaper: {
        base16Scheme = "${themeSpecialisations.mkThemeBase16Scheme "home-" name wallpaper}";
        inherit (wallpaper) image polarity;
      };

      defaultWallpaper = wallpapers.${cfg.default};
    in {
      assertions = [
        {
          assertion = builtins.hasAttr cfg.default wallpapers;
          message = "erinite.home.desktop.theme-specialisations.default must match one of the configured wallpaper names.";
        }
      ];

      erinite.home.desktop.stylix.settings = buildHomeSettings cfg.default defaultWallpaper;
    };
  }
