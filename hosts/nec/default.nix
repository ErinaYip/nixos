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
      network.proxy = true;
      laptop = enabled;
    };

    desktop = {
      hyprland = {
        grass = true;
        settings = {
          monitor = [
            {
              output = "eDP-1";
              mode = "preferred";
              position = "0x0";
              scale = "1.25";
            }
          ];
        };
      };
    };

    cli = {
      codex = enabled;
      git = {
        enable = true;
        user = {
          name = "ErinaYip";
          email = "erinayip@outlook.com";
        };
      };
    };

    browsers = {
      chromium = enabled;
      firefox = enabled;
    };
  };
}
