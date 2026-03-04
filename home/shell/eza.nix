{ config, lib, pkgs, ... }:
let
  shellAliases = {
    tree = "eza --tree";
    ls = "eza";
    ll = "eza -l";
    la = "eza -la";
  };
in {
  programs = {
    eza = {
      enable = true;
      enableBashIntegration = config.programs.bash.enable;
      enableFishIntegration = config.programs.fish.enable;
      enableZshIntegration = config.programs.zsh.enable;
      extraOptions = [
        "--color=always"
        "--group-directories-first"
        "--header"
        "--time-style=long-iso"
      ];
      git = true;
      icons = "always";
    };
    bash.shellAliases = lib.mkIf config.programs.eza.enable shellAliases;
    zsh.shellAliases = lib.mkIf config.programs.eza.enable shellAliases;
    fish.shellAliases = lib.mkIf config.programs.eza.enable shellAliases;
  };
}