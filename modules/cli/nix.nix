{
  lib,
  hostName,
  ...
} @ args:

with lib.erinite; mkModule args {
  category = "cli";
  name = "nix";

  configFn = { ... }:
    mkShellAliases {
      aliases = builtins.listToAttrs (map (x: {
        name = "sn${x.key}";
        value = "sudo nixos-rebuild ${x.cmd} --flake .#${hostName}";
      }) [
        { key = "s"; cmd = "switch"; }
        { key = "b"; cmd = "boot"; }
        { key = "t"; cmd = "test"; }
        { key = "u"; cmd = "build"; }
      ]);
      shells = [ "zsh" ];
    };
}
