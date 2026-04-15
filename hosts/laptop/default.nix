{
  config,
  lib,
  ...
}:
{
  imports = [./hardware.nix];

  system.stateVersion = "25.11";

  users.users.demo = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  demo.home = {
    enable = true;
    user = "demo";
  };

  demo.desktop.hyprland = {
    enable = true;
  };

  demo.cli.git = {
    enable = true;
    user = {
      name = "Laptop Demo";
      email = "laptop@example.com";
    };
  };
}