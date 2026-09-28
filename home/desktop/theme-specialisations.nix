{
  lib,
  pkgs,
  config,
  eriniteLib,
  ...
} @ args: let
  inherit (eriniteLib) mkModule;
in
  mkModule args {
    configFn = _: let
      inherit (config.erinite.wallpapers) wallpapers;

      wallpaperSwitch = pkgs.writeShellApplication {
        name = "erinite-noctalia-wallpaper-changed";
        runtimeInputs = with pkgs; [coreutils gnused systemd];
        text = ''
          set -euo pipefail
          wallpaper="''${NOCTALIA_WALLPAPER_PATH:-}"
          [ -n "$wallpaper" ] || exit 0
          wallpaper="''${wallpaper#file://}"

          case "$wallpaper" in
            ${lib.concatStringsSep "|" (lib.mapAttrsToList (_: wallpaper: wallpaper.path) wallpapers)})
              ;;
            *) exit 0 ;;
          esac

          name="$(basename -- "$wallpaper")"
          name="''${name%.*}"
          current="$(cat /etc/specialisation 2>/dev/null || true)"
          [ "$current" = "$name" ] && exit 0
          token="''${name//-/_}"
          systemctl start --no-block "erinite-theme-switch@$token.service"
        '';
      };
    in {
      programs.noctalia.settings.hooks.wallpaper_changed = lib.getExe wallpaperSwitch;
    };
  }
