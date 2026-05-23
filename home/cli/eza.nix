{
  lib,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "cli";
    name = "eza";

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

        { programs.zsh.shellAliases = {
            tree = "eza --tree";
            ls = "eza";
            ll = "eza -l";
            la = "eza -la";
          }; }
      ];
  }
