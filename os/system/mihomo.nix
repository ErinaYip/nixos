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
      https_proxy = http_proxy;
      all_proxy = http_proxy;

      HTTP_PROXY = http_proxy;
      HTTPS_PROXY = https_proxy;
      ALL_PROXY = all_proxy;
      NO_PROXY = no_proxy;
    in {
      services.mihomo = {
        inherit (cfg) configFile;
        enable = true;
        tunMode = true;
        webui = pkgs.metacubexd;
      };

      environment.sessionVariables = {
        inherit http_proxy https_proxy all_proxy no_proxy HTTPS_PROXY HTTP_PROXY NO_PROXY ALL_PROXY;
      };
    };
  }
