{
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "cli";
    name = "zsh";

    configFn = _: {
      home.packages = [pkgs.any-nix-shell];

      programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        history.size = 10000;

        initContent = ''
          ${builtins.readFile ./init.zsh}
          ${builtins.readFile ./fzf-settings.zsh}
          ${builtins.readFile ./fzf.zsh}
        '';
      };
    };
  }
