{
  config,
  lib,
  hostName,
  defaults,
  ...
}:
let
  inherit (lib.erinite) enabled;
in {
  imports = [./hardware.nix];

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