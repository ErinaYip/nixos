{ config, lib, pkgs, inputs, ... }:
let
  shellAliases = {
    vim = "nvim";
  };
in {
  imports = [ inputs.nixvim.homeModules.default ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
      ripgrep
      fd
    ];
    imports = [
      ./plugins
      ./lsp
      ./colorscheme.nix
      ./options.nix
      ./keymap.nix
    ];
  };
  programs = {
    zsh.shellAliases = shellAliases;
    fish.shellAliases = shellAliases;
  };
}
