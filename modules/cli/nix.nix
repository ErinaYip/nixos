{
  lib,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "cli";
  name = "nix";

  configFn = { ... }: {
    environment.shellAliases = {
      sns = "sudo nixos-rebuild switch --flake";
    };
  };
}
