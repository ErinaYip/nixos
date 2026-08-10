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

  environment.systemPackages = with pkgs; [
    vim
    wget

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

    cowsay
    lolcat
    tldr
    jq
    foremost
    # binwalk
    # john
    ffuf
    feroxbuster
    seclists
    exiftool
    zsteg
    zola

    wavemon
    ddcutil
    i2c-tools

    # wireshark
    # bottles

    libreoffice
  ];

  environment.sessionVariables = {
    SECLISTS = "${pkgs.seclists}/share/wordlists/seclists";
  };
}
