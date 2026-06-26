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
      proxy = mkBoolOpt false "Whether to enable system proxy.";
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

        (lib.mkIf cfg.proxy {
          services.mihomo = {
            enable = true;
            configFile = "/home/era/Downloads/KuKe.yaml";
            tunMode = true;
            webui = pkgs.metacubexd;
          };

          environment.sessionVariables = {
            HTTP_PROXY = "http://127.0.0.1:7890";
            HTTPS_PROXY = "http://127.0.0.1:7890";
            ALL_PROXY = "http://127.0.0.1:7890";
          };
        })
      ];
  }
