{
  lib,
  pkgs,
  eriniteLib,
  ...
}:
with eriniteLib; {
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];
  erinite.home = import ./home.nix { inherit lib pkgs; };

  erinite = {
    presets = {
      common = enabled;
    };

    system = {
      boot.engine = "grub";
      kernel.sched_ext = true;
      network.proxy = true;
      laptop = enabled;
      virtualisation = {
        enable = true;
        podman = true;
        # vbox = true;
      };

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
      obs-studio = enabled;
      hyprland = {
        settings = {
          monitor = [
            "desc:China Star Optoelectronics Technology Co. Ltd MNG007DA5-4, preferred, 1920x0, 1.6, transform, 1"
            "desc:HKC OVERSEAS LIMITED X5 0000000000001, 1920x1080@260.00Hz, 0x0, 1"
          ];
          workspace = [
            "1, monitor:DP-2,      default:true"
            "2, monitor:eDP-1,     default:true"
            "9, monitor:Virtual-1, default:true"
            "2, layout:dwindle"
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
      gaming = enabled;
    };
  };
}
