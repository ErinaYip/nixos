{
  lib,
  default,
  hostName,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    configFn = _:
      lib.mkMerge [
        {
          networking = {
            inherit hostName;

            networkmanager = {
              enable = true;
              wifi.backend = "iwd";
            };
            firewall.enable = true;
          };

          time.timeZone = "Asia/Shanghai";

          hardware.bluetooth = {
            enable = true;
            powerOnBoot = true;
            settings = {
              General = {
                Experimental = true;
                FastConnectable = true;
              };
              Policy = {
                AutoEnable = true;
              };
            };
          };

          users.users.${default.username}.extraGroups = ["networkmanager"];
        }
      ];
  }
