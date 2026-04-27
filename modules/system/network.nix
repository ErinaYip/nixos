{
  lib,
  pkgs,
  default,
  hostName,
  eriniteLib,
  ...
} @ args:

with eriniteLib; mkModule args {
  category = "system";
  name = "network";

  opts = {
    proxy = mkBoolOpt false "Whether to enable system proxy.";
  };

  configFn = { cfg, ... }: lib.mkMerge [
    {
      networking.hostName = hostName;
      time.timeZone = "Asia/Shanghai";

      hardware.bluetooth.enable = true;
      networking.networkmanager = {
        enable = true;
        wifi.backend = "iwd";
      };

      users.users.${default.username}.extraGroups = [ "networkmanager" ];
      networking.firewall.enable = true;
    }

    (lib.mkIf cfg.proxy {
      services.mihomo = {
        enable = true;
        configFile = "/home/era/Downloads/iKuuu_V2.yaml";
        tunMode = true;
        webui = pkgs.metacubexd;
      };

      environment.systemPackages = with pkgs; [ clash-verge-rev ];

      environment.sessionVariables = {
        HTTP_PROXY = "http://127.0.0.1:7890";
        HTTPS_PROXY = "http://127.0.0.1:7890";
        ALL_PROXY = "socks5://127.0.0.1:7891";
      };
    })
  ];
}
