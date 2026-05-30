{
  lib,
  pkgs,
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

      switchTheme = pkgs.writeShellScript "erinite-theme-switch-system" ''
        set -eu

        theme="''${1:?missing theme name}"

        for system in /nix/var/nix/profiles/system /run/current-system; do
          switcher="$system/specialisation/$theme/bin/switch-to-configuration"
          if [ -x "$switcher" ]; then
            exec "$switcher" switch
          fi
        done

        echo "No switchable specialisation found for theme: $theme" >&2
        exit 69
      '';

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
            stylix = mapAttrs (_: mkForce) (buildStylix name wallpaper);
            environment.etc =
              mapAttrs (_: mkForce) (buildEtc name wallpaper)
              // {"erinite-theme/specialisation".text = mkForce name;};
            home-manager.users.${default.username}.erinite.home.desktop = {
              theme-specialisations.default = mkForce name;
              dms.settings.matugenScheme = mkForce wallpaper.type;
            };
          };
        })
        wallpapers;
    };
  }
