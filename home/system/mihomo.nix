{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    opts = {
      configFile = mkStrOpt "${args.config.xdg.configHome}/mihomo/config.yaml" "Mihomo configuration file.";
      proxyPort = mkStrOpt "7890" "Proxy port.";
    };

    configFn = {cfg, ...}: let
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

      systemd.user.services."mihomo" = {
        Unit = {
          Description = "Mihomo daemon, a rule-based proxy in Go";
          Documentation = ["https://wiki.metacubex.one/"];
          After = ["network.target"];
        };

        Service = {
          ExecStart = lib.concatStringsSep " " [
            (lib.getExe pkgs.mihomo)
            "-f ${cfg.configFile}"
            "-ext-ui ${pkgs.metacubexd}"
          ];
          Restart = "on-failure";
          RestartSec = 5;
        };

        Install.WantedBy = ["default.target"];
      };
    };
  }
