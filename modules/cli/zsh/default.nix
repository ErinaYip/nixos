{
  lib,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "cli";
  name = "zsh";

  configFn = { ... }: {
    erinite.home.config.programs.zsh = {
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
