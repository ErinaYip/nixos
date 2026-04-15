{
  lib,
  hostName,
  defaults,
  ...
}: 
with lib.erinite; {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = hostName;
  system.stateVersion = "25.11";

  users.users.${defaults.username} = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  erinite = {
    home = {
      enable = true;
      username = defaults.username;
    };

    system = {
      nix = enabled;

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
