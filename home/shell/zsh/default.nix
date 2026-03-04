{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  
    history.size = 10000;
    shellAliases = {
      man = "tldr";

      githack = "python /home/era/Documents/python/GitHack-master/GitHack.py";
      pker = "python3.11 /home/era/Documents/python/pker-master/pker.py";
    };
    initContent = ''
      ${builtins.readFile ./init.zsh}
      ${builtins.readFile ./fzf-settings.zsh}
      ${builtins.readFile ./fzf.zsh}
    '';
  };
}
