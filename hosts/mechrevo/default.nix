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
