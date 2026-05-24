{
  lib,
  default,
  eriniteLib,
  ...
} @ args: let
  inherit (eriniteLib) mkModule themeSpecialisations;
  inherit (lib) mapAttrs mkForce id;
in
  mkModule args {
    category = "desktop";
    name = "theme-specialisations";

    opts = themeSpecialisations.mkThemeSpecialisationOptions "Wallpapers to turn into theme specialisations.";

    configFn = {cfg, ...}: let
      wallpapers = themeSpecialisations.mkThemeWallpapers cfg;

      buildSystemConfig = name: wallpaper: useForce: let
        maybeForce =
          if useForce
          then mkForce
          else id;
      in {
        stylix = {
          base16Scheme = maybeForce "${themeSpecialisations.mkThemeBase16Scheme "" name wallpaper}";
          image = maybeForce wallpaper.image;
          polarity = maybeForce wallpaper.polarity;
        };

        environment.etc = {
          "erinite-theme/name".text = maybeForce name;
          "erinite-theme/wallpaper".source = maybeForce wallpaper.image;
        };
      };

      defaultWallpaper = wallpapers.${cfg.default};
    in {
      inherit ((buildSystemConfig cfg.default defaultWallpaper false)) stylix;
      environment.etc = (buildSystemConfig cfg.default defaultWallpaper false).environment.etc;

      specialisation =
        mapAttrs (name: wallpaper: {
          configuration = let
            forcedConfig = buildSystemConfig name wallpaper true;
          in {
            inherit (forcedConfig) stylix;
            environment.etc =
              forcedConfig.environment.etc
              // {
                "erinite-theme/specialisation".text = mkForce name;
              };

            home-manager.users.${default.username}.erinite.home.desktop.theme-specialisations.default = mkForce name;
          };
        })
        wallpapers;
    };
  }
