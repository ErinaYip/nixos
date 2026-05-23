{
  hostName,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "cli";
    name = "nix";

    configFn = _: {
      programs.zsh.shellAliases = builtins.listToAttrs (map (x: {
          name = "sn${x.key}";
          value = "sudo nixos-rebuild ${x.cmd} --flake .#${hostName}";
        }) [
          {
            key = "s";
            cmd = "switch";
          }
          {
            key = "b";
            cmd = "boot";
          }
          {
            key = "t";
            cmd = "test";
          }
          {
            key = "u";
            cmd = "build";
          }
        ]);
    };
  }
