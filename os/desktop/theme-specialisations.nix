{
  lib,
  pkgs,
  default,
  config,
  eriniteLib,
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
        theme="''${theme//_/-}"
        exec /nix/var/nix/profiles/system/specialisation/$theme/bin/switch-to-configuration switch
      '';

      buildStylix = _name: wallpaper: {
        inherit (wallpaper) base16Scheme image polarity;
      };

      # Limine's installer always preselects the newest generation's `Default`
      # entry, which boots the plain toplevel of that generation, and it ignores
      # the toplevel that NixOS hands to it, unlike GRUB. Replace that entry's
      # body with the body of this specialisation, so booting `Default` boots the
      # theme that was switched to, just like GRUB's first entry does. The
      # `default_entry: 3` written by the installer keeps pointing at it.
      limineConfPath =
        if config.boot.loader.limine.efiSupport
        then "${config.boot.loader.efi.efiSysMountPoint}/limine/limine.conf"
        else "/boot/limine/limine.conf";

      selectDefaultEntry = name:
        lib.mkIf (config.erinite.os.system.boot.engine == "limine") ''
          conf=${lib.escapeShellArg limineConfPath}
          header=${lib.escapeShellArg "///${name}"}
          body="$(${lib.getExe pkgs.gawk} -v header="$header" '
            $0 == header { found = 1; next }
            found && substr($0, 1, 1) == "/" { exit }
            found
          ' "$conf")"
          [ -n "$body" ] || exit 0
          BODY="$body" ${lib.getExe pkgs.gawk} '
            $0 == "///Default" && !done { print; done = 1; buffering = 1; next }
            buffering && substr($0, 1, 1) == "/" { print ENVIRON["BODY"]; buffering = 0 }
            buffering { next }
            { print }
          ' "$conf" > "$conf.tmp"
          mv "$conf.tmp" "$conf"
        '';
    in {
      security.polkit = {
        enable = true;
        extraConfig = ''
          polkit.addRule(function(action, subject) {
            var unit = action.lookup("unit");
            var verb = action.lookup("verb");

            if (
              action.id == "org.freedesktop.systemd1.manage-units" &&
              unit && unit.indexOf("erinite-theme-switch@") == 0 &&
              unit.endsWith(".service") &&
              verb == "start" &&
              subject.isInGroup("wheel")
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
            boot.loader.limine.extraInstallCommands = selectDefaultEntry name;
            environment.etc."specialisation".text = name;
            stylix = buildStylix name wallpaper;
            home-manager.users.${default.username} = {
              xdg.dataFile."home-manager/specialisation".text = name;
              stylix = buildStylix name wallpaper;
              erinite.wallpapers.default = lib.mkForce name;
            };
          };
        })
        wallpapers;
    };
  }
