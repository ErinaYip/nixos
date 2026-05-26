{eriniteLib, ...} @ args: let
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
    in {
      erinite.home.desktop = {
        stylix.settings = buildStylix cfg.default defaultWallpaper;
        dms.session.wallpaperPath = defaultWallpaper.image;
      };
    };
  }
