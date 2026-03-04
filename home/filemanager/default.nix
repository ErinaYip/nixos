{ config, pkgs, ... }: {
  imports = [
    ./yazi
    ./nemo.nix
  ];
  home.packages = with pkgs; [
    file-roller
  ];
}
