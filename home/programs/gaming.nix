{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    prismlauncher
    hmcl
    heroic
  ];
}