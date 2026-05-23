{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "cli";
    name = "nh";

    configFn = _: {
      programs.zsh.shellAliases = builtins.listToAttrs (
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
