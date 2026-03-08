{ inputs, pkgs, ... }: {
  imports = [
    inputs.erina-vim.homeModules.default
  ];
  home.packages = with pkgs; [
    vscode
    obsidian
    onlyoffice-desktopeditors
    libreoffice
  ];
}
