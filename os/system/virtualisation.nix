{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    opts = {
      podman = mkBoolOpt false "Whether to enable podman";
      vbox = mkBoolOpt false "Whether to enable virtual-box";
      wine = mkBoolOpt false "Whether to enable wine";
    };

    configFn = {cfg, ...}:
      lib.mkMerge [
        (lib.mkIf cfg.podman {
          virtualisation = {
            containers.enable = true;

            podman = {
              enable = true;
              dockerCompat = true;
              defaultNetwork.settings.dns_enabled = true;
            };
          };
          environment.systemPackages = with pkgs; [
            dive
            podman-tui
            docker-compose
          ];
        })

        (lib.mkIf cfg.vbox {
          virtualisation.virtualbox.host = {
            enable = true;
            addNetworkInterface = false;
            enableKvm = true;
          };

          users.extraGroups.vboxusers.members = ["user-with-access-to-virtualbox"];
        })

        (lib.mkIf cfg.wine {
          environment.systemPackages = with pkgs; [
            winetricks
            wineWow64Packages.waylandFull
          ];
        })
      ];
  }
