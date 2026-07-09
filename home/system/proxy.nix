{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    opts = {
      configFile = mkOpt (lib.types.nullOr lib.types.str) null "Mihomo configuration file.";
      proxyPort = mkStrOpt "7890" "Proxy port.";
    };

    configFn = {cfg, ...}: let
      configFile =
        if cfg.configFile != null
        then cfg.configFile
        else "${args.config.xdg.configHome}/mihomo/config.yaml";

      http_proxy = "http://127.0.0.1:${cfg.proxyPort}";
      no_proxy = "localhost,127.0.0.1,::1";
      https_proxy = http_proxy;
      all_proxy = http_proxy;

      HTTP_PROXY = http_proxy;
      HTTPS_PROXY = https_proxy;
      ALL_PROXY = all_proxy;
      NO_PROXY = no_proxy;
    in {
      home = {
        packages = [pkgs.mihomo];
        sessionVariables = {
          inherit http_proxy https_proxy all_proxy no_proxy HTTPS_PROXY HTTP_PROXY NO_PROXY ALL_PROXY;
        };
      };

      systemd.user.services.mihomo = {
        Unit = {
          Description = "Mihomo daemon, a rule-based proxy in Go";
          Documentation = ["https://wiki.metacubex.one/"];
          After = ["network.target"];
        };

        Service = {
          ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${args.config.xdg.configHome}/mihomo";
          ExecStart = lib.concatStringsSep " " (
            lib.filter (arg: arg != "") [
              (lib.getExe pkgs.mihomo)
              "-d ${args.config.xdg.configHome}/mihomo"
              "-f ${configFile}"
              "-ext-ui ${pkgs.metacubexd}"
            ]
          );
          Restart = "on-failure";
          RestartSec = 5;
        };

        Install.WantedBy = ["default.target"];
      };
    };
  }
