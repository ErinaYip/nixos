{ pkgs, lib, config, ... }:
let
  shellAliases = {
    cat = "bat";
  };
in {
  programs = {
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "gruvbox-dark";
      };
      extraPackages = with pkgs.bat-extras; [
        batman
        batpipe
        # batgrep
        # batdiff
      ];
    };
    zsh.shellAliases = lib.mkIf config.programs.eza.enable shellAliases;
    fish.shellAliases = lib.mkIf config.programs.eza.enable shellAliases;
  };
}