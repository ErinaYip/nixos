{ pkgs, ... }: {
  networking.firewall = {
    allowedTCPPorts = [
      25565 # minecraft
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git

    zip
    unzip
    nodejs
    pnpm
    gcc
    gdb
    openjdk
    php
    python3
    uv
  ];
}
