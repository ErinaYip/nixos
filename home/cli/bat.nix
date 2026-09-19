{
  lib,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    configFn = _:
      lib.mkMerge [
        {
          programs.bat = {
            enable = true;
          };
        }

        {
          erinite.home.cli.zsh.aliases = {
            cat = "bat";
          };
        }
      ];
  }
