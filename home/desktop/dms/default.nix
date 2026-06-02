{
  lib,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "desktop";
    name = "dms";

    opts = {
      session = mkOpt lib.types.attrs {} "Dms session state settings.";
    };

    defaultSettings = import ./settings.nix;

    configFn = {
      cfg,
      settings,
      ...
    }:
      lib.mkMerge [
        {
          programs.dank-material-shell = {
            enable = true;

            inherit settings;
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
      ];
  }
