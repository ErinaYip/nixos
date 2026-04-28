{
  lib,
  hostName,
  eriniteLib,
  ...
} @ args:

with eriniteLib; mkModule args {
  category = "cli";
  name = "nix";

  configFn = { ... }:
    mkShellAliases {
      aliases =
        builtins.listToAttrs (map (x: {
          name = "sn${x.key}";
          value = "sudo nixos-rebuild ${x.cmd} --flake .#${hostName}";
        }) [
          { key = "s"; cmd = "switch"; }
          { key = "b"; cmd = "boot"; }
          { key = "t"; cmd = "test"; }
          { key = "u"; cmd = "build"; }
        ])
        // {
          snr = "nix flake update && sudo nixos-rebuild switch --flake .#${hostName}";
        };
      shells = [ "zsh" ];
    };
}
