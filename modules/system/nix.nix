{
  lib,
  default,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "system";
  name = "nix";

  configFn = { ... }: {
    system.stateVersion = default.systemStateVersion;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nix.settings.substituters = [
      "https://cache.nixos.org"
    ];
  };
}
