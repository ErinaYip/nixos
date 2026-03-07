{ config, pkgs, lib, inputs, ... }:
let
  shellAliases = {
    sns = "sudo nixos-rebuild switch --flake ~/nixos";
  };
in  {
  imports = [
    ./eza.nix
    ./zoxide.nix
    ./starship.nix
    ./kitty.nix
    ./zsh
    ./nushell.nix
    ./bat.nix
    ./opencode.nix
  ];

  home.packages = with pkgs;[
    cowsay
    lolcat
    fastfetch
    cava
    tldr
    jq
    foremost
    binwalk
    exiftool
    zsteg
    opencode

    htop
    btop
    wavemon
  ] ++ [
    inputs.codex-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home.sessionVariables = {
    BROWSER = lib.mkDefault "firefox";
    TERMINAL = lib.mkDefault "kitty";
    SHELL = lib.mkDefault "zsh";
    EDITOR = lib.mkDefault "nvim";
    VISUAL = lib.mkDefault "nvim";
    GIT_EDITOR = lib.mkDefault "nvim";
  };

  programs = {
    bash.shellAliases = lib.mkIf config.programs.eza.enable shellAliases;
    zsh.shellAliases = lib.mkIf config.programs.eza.enable shellAliases;
    fish.shellAliases = lib.mkIf config.programs.eza.enable shellAliases;
  };
}
