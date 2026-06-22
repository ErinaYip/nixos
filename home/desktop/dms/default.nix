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
<<<<<<< HEAD

            plugins = {
              # quickCapture = enabled;
              commandRunner = enabled;
            };
=======
>>>>>>> 653ef1db172d14eca4e1a6d7daeb73efa68891e6
          };
        }

        (import ./hyprland.nix args)
      ];
  }
