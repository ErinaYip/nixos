{
  lib,
  pkgs,
  default,
  eriniteLib,
  ...
} @ args: let
  inherit (lib) mapAttrs mkForce;
  inherit (eriniteLib) mkModule;
  inherit (eriniteLib.themeSpecialisations) mkThemeSpecialisationOptions;
in
  mkModule args {
    opts = mkThemeSpecialisationOptions "Wallpapers to turn into theme specialisations.";

    configFn = {cfg, ...}: let
      inherit (cfg) wallpapers;
      defaultWallpaper = wallpapers.${cfg.default};

      switchTheme = pkgs.writeShellScript "erinite-theme-switch-system" ''
        set -eu
        theme="''${1:?missing theme name}"
        exec /nix/var/nix/profiles/system/specialisation/$theme/bin/switch-to-configuration switch
      '';

      buildStylix = _name: wallpaper: {
        inherit (wallpaper) base16Scheme image polarity;
      };
    in {
      security.polkit = {
        enable = true;
        extraConfig = ''
          polkit.addRule(function(action, subject) {
            var unit = action.lookup("unit");
            var verb = action.lookup("verb");

            if (
              action.id == "org.freedesktop.systemd1.manage-units" &&
              unit && unit.match(/^erinite-theme-switch@.+\.service$/) &&
              verb == "start" &&
              subject.user == "${default.username}"
            ) {
              return polkit.Result.YES;
            }
          });
        '';
      };

      systemd.services."erinite-theme-switch@" = {
        description = "Switch to NixOS theme specialisation %I";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${switchTheme} %I";
        };
      };

      stylix = buildStylix cfg.default defaultWallpaper;

      specialisation =
        mapAttrs (name: wallpaper: {
          configuration = {
            stylix = mapAttrs (_: mkForce) (buildStylix name wallpaper);
            environment.etc."specialisation".text = name;
            home-manager.users.${default.username} = {
              xdg.dataFile."home-manager/specialisation".text = name;
              erinite.home.desktop = {
                theme-specialisations.default = mkForce name;
                dms = {
                  session = {
                    isLightMode = mkForce (wallpaper.polarity == "light");
                    wallpaperPath = mkForce wallpaper.path;
                  };
                  settings.matugenScheme = mkForce wallpaper.type;
                };
              };
            };
          };
        })
        wallpapers;
    };
  }
