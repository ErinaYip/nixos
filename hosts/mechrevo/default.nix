{
  lib,
  pkgs,
  ...
}: 
with lib.erinite; {
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];
  erinite.home = import ./home.nix { inherit lib pkgs; };

  erinite = {
    presets = {
      common = enabled;
      gaming = enabled;
    };

    system = {
      boot.engine = "grub";
      network.proxy = true;
      virtualisation.podman = true;

      nvidia = {
        enable = true;
        prime = {
          enable = true;
          nvidiaBusId = "PCI:1:0:0";
          amdgpuBusId = "PCI:6:0:0";
        };
      };
    };

    desktop = {
      hyprland = {
        settings = {
          monitor = [
            "eDP-1, preferred, 1920x0, 1.6, transform, 1"
            "DP-2, 1920x1080@260.00Hz, 0x0, 1"
            # "Virtual-1, disabled"
            "Virtual-1, 1920x1080@60, 9999x9999, 1.25"
          ];
        };
      };
    };

    cli = {
      git = {
        user = {
          name = "ErinaYip";
          email = "erinayip@outlook.com";
        };
      };
    };

    browsers = {
      firefox = enabled;
      chromium = enabled;
    };

    programs = {
      localsend = enabled;
    };
  };
}
