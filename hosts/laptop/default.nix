{
  config,
  lib,
  ...
}:
with lib.demo; {
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

  demo.presets.development = enabled;

  demo.cli.git = {
    enable = true;
    settings.user = {
      name = "Laptop Demo";
      email = "laptop@example.com";
    };
  };
}
