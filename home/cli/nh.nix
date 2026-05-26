{eriniteLib, ...} @ args: let
  inherit (builtins) elemAt concatMap listToAttrs substring;
in
  with eriniteLib;
    mkModule args {
      namespace = ["erinite" "home"];
      category = "cli";
      name = "nh";

      configFn = _: {
        erinite.home.cli.zsh.aliases = listToAttrs (
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
