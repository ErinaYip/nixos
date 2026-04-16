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
    system = {
      nix = enabled;
      nix-ld = enabled;
      users = enabled;
      fcitx5 = enabled;
      i18n = enabled;
      sound = enabled;
      fonts = enabled;
      keyd = enabled;
      sddm = enabled;

      network = {
        enable = true;
        proxy = true;
      };

      virtualisation = {
        enable = true;
        podman = true;
      };

      nvidia = {
        enable = true;
        prime = {
          enable = true;
          nvidiaBusId = "PCI:1:0:0";
          amdgpuBusId = "PCI:6:0:0";
        };
      };

      boot = {
        enable = true;
        engine = "grub";
      };
    };

    desktop = {
      cursor = enabled;
      gtk = enabled;
      qt = enabled;
      dms = enabled;
      matugen = enabled;

      hyprland = {
        enable = true;
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
      yazi = enabled;
      starship = enabled;
      bat = enabled;
      eza = enabled;
      fastfetch = enabled;
      kitty = enabled;
      zoxide = enabled;
      nvim = enabled;

      git = {
        enable = true;
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
      localsend = enabled;
    };
  };
}
