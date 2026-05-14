{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    category = "desktop";
    name = "streaming";

    opts = {
      host = {
        enable = mkBoolOption false "Whether to enable streaming host.";
        package =
          mkOpt
          (lib.types.enum ["sunshine"])
          "sunshine"
          "The streaming software to use.";
        autoStart = mkBoolOption false "Whether to start sunshine on launch.";
      };
      guest.enable = mkBoolOption flase "Whether to enable streaming guest.";
    };

    configFn = {cfg, ...}: {
      services = lib.mkIf cfg.host.enable {
        sunshine = lib.mkif (cfg.host.package == "sunshine") {
          enable = true;
          inherit (cfg.host) autoStart;
          capSysAdmin = true;
          openFirewall = true;
        };
      };

      environment.package = lib.mkIf cfg.guest.enable [pkgs.moonlight];
    };
  }
