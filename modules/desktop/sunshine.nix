{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    category = "desktop";
    name = "sunshine";

    opts = {
      autoStart = mkBoolOption false "Whether to start sunshine on launch.";
    };

    configFn = {cfg, ...}: {
      services.sunshine = {
        enable = true;
        autoStart = cfg.autoStart;
        capSysAdmin = true;
        openFirewall = true;
      };
    };
  }
