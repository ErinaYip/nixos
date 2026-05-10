{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    category = "system";
    name = "virtualisation";

    opts = {
      podman = mkBoolOpt false "Whether to enable podman";
      vbox = mkBoolOpt false "Whether to enable virtual-box";
    };

    configFn = {cfg, ...}:
      lib.mkMerge [
        (lib.mkIf cfg.podman {
          virtualisation.containers.enable = true;
          virtualisation = {
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
          virtualisation.virtualbox = {
            host.enable = true;
          };
          users.extraGroups.vboxusers.members = [
            "user-with-access-to-virtualbox"
            "djw"
          ];
        })
      ];
  }
