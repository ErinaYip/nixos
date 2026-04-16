{
  lib,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "programs";
  name = "localshare";

  configFn = { ... }: {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
