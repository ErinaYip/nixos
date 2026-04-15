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

    system.nvidia = {
      enable = true;
      prime = {
        enable = true;
        nvidiaBusId = "PCI:1:0:0";
        amdgpuBusId = "PCI:6:0:0";
      };
    };

    desktop.hyprland = enabled;

    cli.git = {
      enable = true;
      user = {
        name = "Laptop Demo";
        email = "laptop@example.com";
      };
    };
  };
}
