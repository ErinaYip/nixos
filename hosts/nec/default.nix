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
            "eDP-1, preferred, 0x0, 1.25"
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
