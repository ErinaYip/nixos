{
  lib,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "cli";
  name = "eza";

  configFn = { ... }: let
    shellAliases = {
      tree = "eza --tree";
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
    };
  in {
    erinite.home.config.programs.eza = {
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

    programs = {
      bash.shellAliases = shellAliases;
      zsh.shellAliases = shellAliases;
      fish.shellAliases = shellAliases;
    };
  };
}
