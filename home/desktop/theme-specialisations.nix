{
  lib,
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args: let
  inherit (lib) concatMapStringsSep concatStringsSep escapeShellArg generators mapAttrsToList;
  inherit (eriniteLib) mkModule;
  inherit (eriniteLib.themeSpecialisations) mkThemeBase16Scheme mkThemeSpecialisationOptions;

  raw = generators.mkLuaInline;
  bind = mods: dispatcher: {
    _args = [
      mods
      (raw dispatcher)
      {}
    ];
  };
in
  mkModule args {
    namespace = ["erinite" "home"];
    category = "desktop";
    name = "theme-specialisations";

    opts = mkThemeSpecialisationOptions "Wallpapers to turn into Home Manager theme settings.";

    configFn = {cfg, ...}: let
      inherit (cfg) wallpapers;
      themeNames = builtins.attrNames wallpapers;
      themesFile = pkgs.writeText "erinite-themes" "${concatStringsSep "\n" themeNames}\n";
      dmsPackage = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.dms-shell;

      wallpaperFileName = name: wallpaper: let
        baseName = builtins.baseNameOf (toString wallpaper.image);
        match = builtins.match ".*\\.([A-Za-z0-9]+)$" baseName;
        extension =
          if match == null
          then "png"
          else builtins.head match;
      in "${name}.${extension}";

      wallpaperLinks =
        mapAttrsToList
        (name: wallpaper: {
          name = wallpaperFileName name wallpaper;
          path = wallpaper.image;
        })
        wallpapers;

      wallpaperDir = pkgs.linkFarm "erinite-theme-wallpapers" wallpaperLinks;
      wallpaperPath = name: "${wallpaperDir}/${wallpaperFileName name wallpapers.${name}}";
      defaultWallpaper = wallpapers.${cfg.default};
      defaultWallpaperPath = wallpaperPath cfg.default;
      wallpaperCase =
        concatMapStringsSep
        "\n"
        (name: ''
          ${escapeShellArg (wallpaperFileName name wallpapers.${name})})
            theme=${escapeShellArg name}
            ;;
        '')
        themeNames;

      buildStylix = name: wallpaper: {
        base16Scheme = "${mkThemeBase16Scheme "" name wallpaper}";
        inherit (wallpaper) image polarity;
      };

      themeSwitch = pkgs.writeShellApplication {
        name = "erinite-theme-switch";
        runtimeInputs = with pkgs; [
          coreutils
          gnugrep
          dmsPackage
          systemd
        ];
        text = ''
          set -euo pipefail

          current="$(cat /etc/erinite-theme/name 2>/dev/null || true)"

          list_themes() {
            cat ${themesFile}
          }

          usage() {
            printf '%s\n\n%s\n%s\n%s\n' \
              'Usage: erinite-theme-switch [theme]' \
              'Options:' \
              '  --current  print the active theme' \
              '  --list     list available themes'
          }

          case "''${1-}" in
            --current)
              printf '%s\n' "$current"
              exit 0
              ;;
            --list)
              list_themes
              exit 0
              ;;
            -h|--help)
              usage
              exit 0
              ;;
          esac

          if [ "$#" -gt 1 ]; then
            usage >&2
            exit 64
          fi

          if [ "$#" -eq 1 ]; then
            choice="$1"
          else
            exec dms ipc call dankdash wallpaper
          fi

          if ! grep -Fxq "$choice" ${themesFile}; then
            printf 'Unknown theme: %s\n' "$choice" >&2
            exit 64
          fi

          if [ "$choice" = "$current" ]; then
            exit 0
          fi

          unit="$(systemd-escape --template=erinite-theme-switch@.service "$choice")"
          systemctl start "$unit"
        '';
      };

      wallpaperHook = pkgs.writeShellApplication {
        name = "erinite-theme-switch-from-wallpaper";
        runtimeInputs = with pkgs; [
          coreutils
        ];
        text = ''
          set -euo pipefail

          wallpaper="''${1-}"
          if [ -z "$wallpaper" ]; then
            exit 0
          fi

          file_name="$(basename -- "$wallpaper")"
          theme=""

          case "$file_name" in
          ${wallpaperCase}
          esac

          if [ -z "$theme" ]; then
            exit 0
          fi

          current="$(cat /etc/erinite-theme/name 2>/dev/null || true)"
          if [ "$theme" = "$current" ]; then
            exit 0
          fi

          exec ${themeSwitch}/bin/erinite-theme-switch "$theme"
        '';
      };

      switcher = pkgs.symlinkJoin {
        name = "erinite-theme-switch";
        paths = [
          themeSwitch
          wallpaperHook
        ];
      };
    in {
      erinite.home.desktop = {
        stylix.settings = buildStylix cfg.default defaultWallpaper;
        dms = {
          session.wallpaperPath = lib.mkForce defaultWallpaperPath;
          settings.matugenScheme = defaultWallpaper.type;
        };
      };

      home.packages = [switcher];

      programs.dank-material-shell.plugins.wallpaperWatcherDaemon = {
        src = inputs.dms + "/quickshell/PLUGINS/WallpaperWatcherDaemon";
        settings.scriptPath = "${wallpaperHook}/bin/erinite-theme-switch-from-wallpaper";
      };

      xdg.desktopEntries.erinite-theme-switch = {
        name = "Theme Switcher";
        exec = "erinite-theme-switch";
        icon = "preferences-desktop-wallpaper";
        terminal = false;
        categories = ["Settings" "Utility"];
      };

      wayland.windowManager.hyprland.settings.bind = [
        (bind "SUPER + Y" ''hl.dsp.exec_cmd("erinite-theme-switch")'')
      ];
    };
  }
