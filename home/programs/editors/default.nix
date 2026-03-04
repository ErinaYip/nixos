{ config, pkgs, ... }: {
  imports = [
    ./nixvim
  ];
  home.packages = with pkgs; [
    vscode
    obsidian
    onlyoffice-desktopeditors
    libreoffice
  ];
}
