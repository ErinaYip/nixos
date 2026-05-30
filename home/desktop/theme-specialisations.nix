{
  lib,
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args: let
  inherit (lib) concatMapStringsSep concatStringsSep escapeShellArg generators mapAttrsToList;
  inherit (eriniteLib) mkModule;
  inherit (eriniteLib.themeSwitching) mkHomePrograms;
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

      switcher = mkHomePrograms {
        inherit dmsPackage themesFile wallpaperCase;
      };
    in {
      erinite.home.desktop = {
        stylix.settings = buildStylix cfg.default defaultWallpaper;
        dms = {
          session.wallpaperPath = lib.mkForce defaultWallpaperPath;
          settings.matugenScheme = defaultWallpaper.type;
        };
      };

      home.packages = [switcher.package];

      programs.dank-material-shell.plugins.wallpaperWatcherDaemon = {
        src = inputs.dms + "/quickshell/PLUGINS/WallpaperWatcherDaemon";
        settings.scriptPath = "${switcher.wallpaperHook}/bin/erinite-theme-switch-from-wallpaper";
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
