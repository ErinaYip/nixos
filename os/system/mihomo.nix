{
  pkgs,
  config,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    opts = {
      configFile = mkStrOpt "${config.xdg.configHome}/mihomo/config.yaml" "Mihomo configuration file.";
      proxyPort = mkStrOpt "7890" "Mihomo proxy port.";
    };

    configFn = {cfg, ...}: let
      http_proxy = "http://127.0.0.1:${cfg.proxyPort}";
      no_proxy = "localhost,127.0.0.1,::1";
    in {
      services.mihomo = {
        inherit (cfg) configFile;
        enable = true;
        tunMode = true;
        webui = pkgs.metacubexd;
      };

      networking.proxy = {
        default = http_proxy;
        noProxy = no_proxy;
      };
    };
  }
