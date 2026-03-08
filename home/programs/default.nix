{ config, pkgs, ... }: {
  imports = [
    ./communication.nix
    ./gaming.nix
    ./media.nix
    ./editors.nix
    # ./xdg.nix

  ];

  home.packages = with pkgs;[
    localsend
    wireshark

    fuzzel

    john
    python312Packages.dirsearch
  ];
}
