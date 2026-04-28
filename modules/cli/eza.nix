{
  lib,
  eriniteLib,
  ...
} @ args:

with eriniteLib; mkModule args {
  category = "cli";
  name = "eza";

  configFn = { ... }: lib.mkMerge [
    {
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
    }

    (mkShellAliases {
      aliases = {
        tree = "eza --tree";
        ls = "eza";
        ll = "eza -l";
        la = "eza -la";
      };
      shells = [ "zsh" ];
    })
  ];
}
