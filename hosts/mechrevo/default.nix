{
  lib,
  ...
}: 
with lib.erinite; {
  imports = [
    ./hardware-configuration.nix
  ];

  erinite = {
    system = {
      nix = enabled;
      nix-ld = enabled;
      users = enabled;
      fcitx5 = enabled;
      i18n = enabled;
      networkmanager = enabled;

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

    desktop.hyprland = enabled;

    cli.git = {
      enable = true;
      user = {
        name = "ErinaYip";
        email = "erinayip@outlook.com";
      };
    };
  };
}
