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

  erinite = {
    system = {
      nix = enabled;
      users = enabled;
    };

    cli.git = {
      enable = true;
      user = {
        name = "Laptop Demo";
        email = "laptop@example.com";
      };
    };
  };
}