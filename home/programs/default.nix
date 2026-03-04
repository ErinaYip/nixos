{ config, pkgs, ... }: {
  imports = [
    ./communication.nix
    ./gaming.nix
    ./media.nix
    # ./xdg.nix

    ./editors
  ];

  home.packages = with pkgs;[
    localsend
    wireshark

    fuzzel

    john
    python312Packages.dirsearch
  ];
}