{
  lib,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  category = "programs";
  name = "localsend";

  configFn = {...}: {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
