{ pkgs, lib, config, ... }:
let
  shellAliases = {
    cat = "batpipe";
    less = "bat";
    man = "batman";
  };
in {
  programs = {
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
      extraPackages = with pkgs.bat-extras; [
        batman
        batpipe
        batgrep
        batdiff
      ];
    };
    zsh.shellAliases = lib.mkIf config.programs.eza.enable shellAliases;
    fish.shellAliases = lib.mkIf config.programs.eza.enable shellAliases;
  };
}
