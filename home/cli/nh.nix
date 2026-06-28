{eriniteLib, ...} @ args: let
  inherit (builtins) elemAt listToAttrs substring;

  commands = [
    ["s" "switch"]
    ["b" "boot"]
    ["t" "test"]
    ["u" "build"]
  ];

  mkAlias = target: extraArgs: cmd: {
    name = "n${substring 0 1 target}${elemAt cmd 0}";
    value = "nh ${target} ${elemAt cmd 1}${extraArgs}";
  };
in
  with eriniteLib;
    mkModule args {
      configFn = _: {
        erinite.home.cli.zsh.aliases =
          listToAttrs
          (
            (map (mkAlias "os" "") commands)
            ++ (map (mkAlias "home" " --no-specialisation") commands)
          );
      };
    }
