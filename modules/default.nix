{ config, pkgs, lib, ... }: {
  imports = [
    ./devices.nix
    ./fonts.nix
    ./i18n.nix
    ./loginsession.nix
    ./network.nix
    ./nix-ld.nix
    ./virtualization.nix
  ];

  environment.localBinInPath = true;
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];
  environment.systemPackages = with pkgs; [
    vim
    wget
    git

    unzip
    libnotify
    nodejs
    pnpm
    gcc
    gdb
    openjdk
    php
    python3
    uv
    android-tools

    wineWow64Packages.waylandFull
    winetricks
    lutris
  ];

  programs.direnv.enable = true;
  services.tuned.enable = true;
  programs.xfconf.enable = true;
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  programs.hyprland.enable = true;

  # services.sunshine = {
  #   enable = true;
  #   autoStart = true;
  #   capSysAdmin = true;
  #   openFirewall = true;
  # };
}
