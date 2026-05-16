{eriniteLib, ...}:
with eriniteLib; {
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];

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
        vbox = true;
        wine = true;
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
            {
              output = "eDP-1";
              mode = "preferred";
              position = "1920x0";
              scale = "1.6";
              transform = 1;
            }
            {
              output = "eDP-2";
              mode = "preferred";
              position = "1920x0";
              scale = "1.6";
              transform = 1;
            }
            {
              output = "DP-2";
              mode = "1920x1080@260.00Hz";
              position = "0x0";
              scale = "1";
            }
            {
              output = "DP-3";
              mode = "1920x1080@260.00Hz";
              position = "0x0";
              scale = "1";
            }
          ];
          workspace_rule = [
            {
              workspace = "1";
              monitor = "DP-2";
              default = true;
            }
            {
              workspace = "1";
              monitor = "DP-3";
              default = true;
            }
            {
              workspace = "2";
              monitor = "eDP-1";
              default = true;
            }
            {
              workspace = "2";
              monitor = "eDP-2";
              default = true;
            }
            {
              workspace = "2";
              layout = "dwindle";
            }
          ];
        };
      };
    };

    cli = {
      codex = enabled;
      opencode = enabled;
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
