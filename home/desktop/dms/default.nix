{
  lib,
  eriniteLib,
  config,
  ...
} @ args:
with eriniteLib; let
  bars = import ./bars.nix;
  inherit (config.erinite) wallpapers;
  wallpaper = wallpapers.wallpapers.${wallpapers.default};
in
  mkModule args {
    opts = {
      session = mkDefaultOpt (lib.types.attrsOf lib.types.anything) {
        isLightMode = wallpaper.polarity == "light";
        wallpaperPath = wallpaper.path;
      } "Dms session state settings.";

      bars = {
        mainBar = mkOpt (lib.types.attrsOf lib.types.anything) {} "Main DMS bar overrides.";
        subBar = mkOpt (lib.types.attrsOf lib.types.anything) {} "Secondary DMS bar overrides.";
      };
    };

    defaultSettings =
      import ./settings.nix
      // {matugenScheme = wallpaper.type;};

    configFn = {
      cfg,
      settings,
      ...
    }:
      lib.mkMerge [
        {
          programs.dank-material-shell = {
            enable = true;

            settings =
              settings
              // {
                barConfigs = [
                  (lib.recursiveUpdate bars.mainBar cfg.bars.mainBar)
                  (lib.recursiveUpdate bars.subBar cfg.bars.subBar)
                ];
              };
            inherit (cfg) session;

            systemd = {
              enable = true;
              inherit (cfg) restartIfChanged;
            };

            enableSystemMonitoring = true;
            enableVPN = false;
            enableDynamicTheming = true;
            enableAudioWavelength = true;
            enableCalendarEvents = true;
            enableClipboardPaste = true;
          };
        }

        (import ./hyprland.nix args)
        (import ./niri.nix)
      ];
  }
