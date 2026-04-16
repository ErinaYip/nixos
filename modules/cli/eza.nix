{
  lib,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "cli";
  name = "eza";

  configFn = { ... }: {
    erinite.home.programs.eza = {
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

    environment.shellAliases = {
      tree = "eza --tree";
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
    };
  };
}
