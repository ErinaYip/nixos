{ config, pkgs, ... }: {
  imports = [
    ./gtk.nix
    ./qt.nix
    ./cursor.nix
    ./fcitx5.nix

    ./hyprland
    ./niri.nix
  ];
  home.packages = with pkgs; [
    brightnessctl
    wl-clipboard
    cliphist
    grim
    slurp

    nwg-look
  ];
  services.polkit-gnome.enable = true;
}
