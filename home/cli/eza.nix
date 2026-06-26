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
          programs.eza = {
            enable = true;
            enableBashIntegration = true;
            enableFishIntegration = true;
            enableZshIntegration = true;
            extraOptions = [
              "--color=always"
              "--group-directories-first"
              "--header"
              "--time-style=long-iso"
            ];
            git = true;
            icons = "always";
          };
        }

        {
          erinite.home.cli.zsh.aliases = {
            tree = "eza --tree";
            ls = "eza";
            ll = "eza -l";
            la = "eza -la";
          };
        }
      ];
  }
