{ inputs, pkgs, ... }: {
  home.packages = with pkgs; [
    vscode
    obsidian
    onlyoffice-desktopeditors
    libreoffice
    inputs.erina-vim.packages.${stdenv.hostPlatform.system}.default
  ];
}
