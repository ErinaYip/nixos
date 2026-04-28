{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:

eriniteLib.mkModule args {
  category = "system";
  name = "kernel";

  configFn = { ... }: {
    boot.kernelPackages = pkgs.linuxPackages;

    services.scx = {
      enable = true;
      scheduler = "scx_rusty"; 
    };
  };
}
