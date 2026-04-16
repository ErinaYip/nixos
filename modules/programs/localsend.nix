{
  lib,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "programs";
  name = "localsend";

  configFn = { ... }: {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
