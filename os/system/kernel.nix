{
  pkgs,
  lib,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    opts = {
      sched_ext = mkBoolOpt false "Whether to enable sched_ext";
    };

    configFn = {cfg, ...}: {
      boot.kernelPackages = pkgs.linuxPackages;
      boot.kernel.sysctl = {
        "fs.inotify.max_user_watches" = 2097152;
        "fs.inotify.max_user_instances" = 1048576;
        "fs.inotify.max_queued_events" = 65536;
      };

      services.scx = lib.mkIf cfg.sched_ext {
        enable = true;
        scheduler = "scx_rusty";
      };
    };
  }
