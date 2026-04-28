{
  pkgs,
  lib,
  eriniteLib,
  ...
} @ args:

with eriniteLib; mkModule args {
  category = "system";
  name = "kernel";

  opts = {
    sched_ext = mkBoolOpt false "Whether to enable sched_ext";
  };

  configFn = { cfg, ... }: {
    boot.kernelPackages = pkgs.linuxPackages_latest;

    services.scx = lib.mkIf cfg.sched_ext {
      enable = true;
      scheduler = "scx_rusty";
    };
  };
}
