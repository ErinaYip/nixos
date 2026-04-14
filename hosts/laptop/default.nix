{
  config,
  lib,
  ...
}:
with lib.demo; {
  imports = [./hardware.nix];

  system.stateVersion = "24.11";
  demo.user.name = "demo";

  users.users.${config.demo.user.name} = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  demo.presets.development = enabled;

  demo.cli.git = {
    userName = "Laptop Demo";
    userEmail = "laptop@example.com";
  };
}
