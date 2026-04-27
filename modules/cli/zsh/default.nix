{
  lib,
  eriniteLib,
  ...
} @ args:

eriniteLib.mkModule args {
  category = "cli";
  name = "zsh";

  configFn = { ... }: {
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
