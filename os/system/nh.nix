{
  eriniteLib,
  default,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    category = "system";
    name = "nh";

    opts = {
      flake = mkStrOpt "/home/${default.username}/nixos" "The path to the flake to use";
    };

    configFn = {cfg, ...}: {
      programs.nh = {
        enable = true;
        clean = {
          enable = true;
          extraArgs = "--keep-since 4d --keep 3";
        };
        inherit (cfg) flake;
      };

      environment.shellAliases = builtins.listToAttrs (
        builtins.concatMap (
          target:
            map (cmd: {
              name = "n${builtins.substring 0 1 target}${cmd.key}";
              value = "nh ${target} ${cmd.cmd}";
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
            ]
        ) ["os" "home"]
      );
    };
  }
