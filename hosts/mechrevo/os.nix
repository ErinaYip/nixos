{
  pkgs,
  default,
  ...
}: {
  networking.firewall = {
    allowedTCPPorts = [
      25565 # minecraft
      11010 # easytier
    ];
  };

  hardware.i2c.enable = true;
  users.users.${default.username}.extraGroups = ["i2c"];

  environment.etc.hosts.enable = false;

  environment.systemPackages = with pkgs; [
    wget
    file
    zip
    unzip
    nodejs
    pnpm
    gcc
    openjdk
    php
    python3
    uv
    tldr
    jq

    wavemon
    ddcutil
    i2c-tools

    libreoffice

    ollama-cuda
  ];
}
