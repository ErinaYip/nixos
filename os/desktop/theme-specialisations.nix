{
  lib,
  default,
  eriniteLib,
  ...
} @ args: let
  inherit (lib) mapAttrs mkForce;
  inherit (eriniteLib) mkModule;
  inherit (eriniteLib.themeSpecialisations) mkThemeBase16Scheme mkThemeSpecialisationOptions;
in
  mkModule args {
    category = "desktop";
    name = "theme-specialisations";

    opts = mkThemeSpecialisationOptions "Wallpapers to turn into theme specialisations.";

    configFn = {cfg, ...}: let
      inherit (cfg) wallpapers;
      defaultWallpaper = wallpapers.${cfg.default};

      buildStylix = name: wallpaper: {
        base16Scheme = "${mkThemeBase16Scheme "" name wallpaper}";
        inherit (wallpaper) image polarity;
      };
      buildEtc = name: wallpaper: {
        "erinite-theme/name".text = name;
        "erinite-theme/wallpaper".source = wallpaper.image;
      };
    in {
      stylix = buildStylix cfg.default defaultWallpaper;
      environment.etc = buildEtc cfg.default defaultWallpaper;

      specialisation =
        mapAttrs (name: wallpaper: {
          configuration = {
            stylix = mapAttrs (_: mkForce) (buildStylix name wallpaper);
            environment.etc =
              mapAttrs (_: mkForce) (buildEtc name wallpaper)
              // {"erinite-theme/specialisation".text = mkForce name;};

            home-manager.users.${default.username}.erinite.home.desktop.theme-specialisations.default = mkForce name;
          };
        })
        wallpapers;
    };
  }
