{
  lib,
  default,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "system";
  name = "network";

  opts = {
    proxy = lib.erinite.mkBoolOpt true "Whether to enable system proxy.";
  };

  configFn = { ... }: {
    networking.hostName = "nixos";
    time.timeZone = "Asia/Shanghai";

    hardware.bluetooth.enable = true;
    networking.networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };

    users.users.${default.username}.extraGroups = [ "networkmanager" ];
    networking.firewall.enable = true;
  };
}
