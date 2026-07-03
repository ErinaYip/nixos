{
  pkgs,
  default,
  ...
}: {
  networking.firewall = {
    allowedTCPPorts = [
      25565 # minecraft
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
    python312Packages.dirsearch

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
