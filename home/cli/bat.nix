{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "cli";
    name = "bat";

    configFn = _:
      lib.mkMerge [
        {
          programs.bat = {
            enable = true;
            extraPackages = with pkgs.bat-extras; [
              batman
              batpipe
              batgrep
              batdiff
            ];
          };
        }

        {
          erinite.home.cli.zsh.aliases = {
            cat = "batpipe";
            less = "bat";
            man = "batman";
          };
        }
      ];
  }
