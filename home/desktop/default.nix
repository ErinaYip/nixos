{ config, pkgs, ... }: {
  imports = [
    ./gtk.nix
    ./qt.nix
    ./cursor.nix

    ./hyprland
    ./niri.nix
  ];
  home.packages = with pkgs; [
    brightnessctl
    wl-clipboard
    cliphist

    nwg-look
  ];
  services.polkit-gnome.enable = true;
}
