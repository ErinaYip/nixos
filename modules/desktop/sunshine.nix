{
  lib,
  ...
} @ args:

with lib.erinite; mkModule args {
  category = "desktop";
  name = "sunshine";

  opts = {
    autoStart = mkBoolOption false "Whether to start sunshine on launch.";
  };

  configFn = { ... }: {
    services.sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}
