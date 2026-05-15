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
        enable = mkBoolOpt false "Whether to enable streaming host.";
        package =
          mkOpt
          (lib.types.enum ["sunshine"])
          "sunshine"
          "The streaming software to use.";
        autoStart = mkBoolOpt false "Whether to start sunshine on launch.";
      };
      guest.enable = mkBoolOpt false "Whether to enable streaming guest.";
    };

    configFn = {cfg, ...}: {
      services = lib.mkIf cfg.host.enable {
        sunshine = lib.mkIf (cfg.host.package == "sunshine") {
          enable = true;
          inherit (cfg.host) autoStart;
          capSysAdmin = true;
          openFirewall = true;
        };
      };

      environment.systemPackages = lib.mkIf cfg.guest.enable [pkgs.moonlight];
    };
  }
