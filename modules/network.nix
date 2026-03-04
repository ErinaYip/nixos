{ config, pkgs, ... }: {
  time.timeZone = "Asia/Shanghai";

  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80
      443
      53317 # localsend
    ];
    allowedUDPPorts = [
      53317 # localsend
    ];
    # allowedTCPPortRanges = [
    #   { from = 1; to = 60999; }
    # ];
    # allowedUDPPortRanges = [
    #   { from = 1; to = 60999; }
    # ];
  };

  services.mihomo = {
    enable = true;
    configFile = "/home/era/Downloads/erameta.yaml";
    tunMode = true;
    webui = pkgs.metacubexd;
  };

  environment.sessionVariables = {
    HTTP_PROXY = "http://127.0.0.1:7890";
    HTTPS_PROXY = "http://127.0.0.1:7890";
    ALL_PROXY = "socks5://127.0.0.1:7891";
  };
}
