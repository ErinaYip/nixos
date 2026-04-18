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

  erinite = {
    presets = {
      common = enabled;
    };

    system = {
      boot.engine = "grub";
      network.proxy = false;
      # fcitx5 = lib.mkForce disabled;
    };

    desktop = {
      hyprland = {
        settings = {
          monitor = [
            "eDP-1, preferred, 0x0, 1.25"
          ];
        };
      };
    };

    # development.development = enabled;

    cli = {
      fastfetch = lib.mkForce disabled;
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
    };

    programs = {
      localsend = enabled;
    };
  };
}
