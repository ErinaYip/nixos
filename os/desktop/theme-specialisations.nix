{
  lib,
  pkgs,
  default,
  eriniteLib,
  config,
  ...
} @ args: let
  inherit (lib) mapAttrs;
  inherit (eriniteLib) mkModule;
in
  mkModule args {
    configFn = _: let
      inherit (config.erinite.wallpapers) wallpapers;

      switchTheme = pkgs.writeShellScript "erinite-theme-switch-system" ''
        set -eu
        theme="''${1:?missing theme name}"
        exec /nix/var/nix/profiles/system/specialisation/$theme/bin/switch-to-configuration switch
      '';

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

      specialisation =
        mapAttrs (name: wallpaper: {
          configuration = {
            stylix = buildStylix name wallpaper;
            environment.etc."specialisation".text = name;
            home-manager.users.${default.username} = {
              xdg.dataFile."home-manager/specialisation".text = name;
              stylix = buildStylix name wallpaper;
              programs.dank-material-shell = buildDms wallpaper;
            };
          };
        })
        wallpapers;
    };
  }
