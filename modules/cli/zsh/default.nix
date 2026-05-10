{
  eriniteLib,
  pkgs,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    category = "cli";
    name = "zsh";

    configFn = _: {
      programs.zsh = enabled;
      environment.systemPackages = [
        pkgs.any-nix-shell
      ];

      erinite.home.programs.zsh = {
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
