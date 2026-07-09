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
      httpProxy = mkStrOpt "http://127.0.0.1:7890" "HTTP proxy URL for terminal sessions.";
      allProxy = mkStrOpt "http://127.0.0.1:7890" "Fallback proxy URL for terminal sessions.";
      noProxy = mkStrOpt "localhost,127.0.0.1,::1" "Hosts that should bypass the terminal proxy.";
      webui = mkOpt (lib.types.nullOr lib.types.path) pkgs.metacubexd "Mihomo external UI path.";
      extraOpts = mkOpt (lib.types.nullOr lib.types.str) null "Extra command line options for mihomo.";
      tunMode = mkBoolOpt false "Whether to use the system capability wrapper for TUN mode.";
    };

    configFn = {cfg, ...}: let
      configFile =
        if cfg.configFile != null
        then cfg.configFile
        else "${args.config.xdg.configHome}/mihomo/config.yaml";
      mihomoBin =
        if cfg.tunMode
        then "/run/wrappers/bin/mihomo"
        else lib.getExe pkgs.mihomo;
    in {
      home = {
        packages = [pkgs.mihomo];
        sessionVariables = {
          HTTP_PROXY = cfg.httpProxy;
          HTTPS_PROXY = cfg.httpProxy;
          ALL_PROXY = cfg.allProxy;
          NO_PROXY = cfg.noProxy;
          http_proxy = cfg.httpProxy;
          https_proxy = cfg.httpProxy;
          all_proxy = cfg.allProxy;
          no_proxy = cfg.noProxy;
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
              mihomoBin
              "-d ${args.config.xdg.configHome}/mihomo"
              "-f ${configFile}"
              (lib.optionalString (cfg.webui != null) "-ext-ui ${cfg.webui}")
              (lib.optionalString (cfg.extraOpts != null) cfg.extraOpts)
            ]
          );
          Restart = "on-failure";
          RestartSec = 5;
        };

        Install.WantedBy = ["default.target"];
      };
    };
  }
