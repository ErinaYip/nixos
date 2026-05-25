{
  eriniteLib,
  default,
  ...
} @ args: let
  inherit (builtins) concatMap elemAt listToAttrs substring;
in
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

        environment.shellAliases = listToAttrs (
          concatMap (
            target:
              map (cmd: {
                name = "n${substring 0 1 target}${elemAt cmd 0}";
                value = "nh ${target} ${elemAt cmd 1}";
              }) [
                ["s" "switch"]
                ["b" "boot"]
                ["t" "test"]
                ["u" "build"]
              ]
          ) ["os" "home"]
        );
      };
    }
