{
  config,
  lib,
  ...
}:
with lib.zenyte; {
  imports = [./hardware.nix];

  system.stateVersion = "25.11";

  users.users.demo = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  zenyte.home = {
    enable = true;
    user = "demo";
  };

  zenyte.presets.development = enabled;

  zenyte.cli.git = {
    enable = true;
    settings.user = {
      name = "Laptop Demo";
      email = "laptop@example.com";
    };
  };
}
