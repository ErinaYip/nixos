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

  erinite = {
    home = {
      enable = true;
      username = defaults.username;
    };

    system = {
      nix = enabled;
      users = enabled;
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