{
  lib,
  pkgs,
  default,
  hostName,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    opts = {
      proxyTun = mkBoolOpt false "Whether to allow the user mihomo service to use TUN mode.";
    };

    configFn = {cfg, ...}:
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

        (lib.mkIf cfg.proxyTun {
          security.wrappers.mihomo = {
            owner = "root";
            group = "root";
            capabilities = "cap_net_admin,cap_net_raw,cap_net_bind_service+ep";
            source = lib.getExe pkgs.mihomo;
          };

          networking.firewall.checkReversePath = lib.mkDefault "loose";
        })
      ];
  }
