{
  pkgs,
  eriniteLib,
  ...
}:
with eriniteLib; {
  networking.firewall = {
    allowedTCPPorts = [
      25565 # minecraft
    ];
  };

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
    binwalk
    # john
    ffuf
    feroxbuster
    seclists
    exiftool
    zsteg
    zola
    python312Packages.dirsearch

    wavemon

    # wireshark
    # bottles

    qq
    wechat
    materialgram

    vscode
    obsidian
    libreoffice
  ];

  erinite.home = {
    programs.cava = enabled;

    wayland.windowManager.hyprland.settings = {
      monitor = [
        "eDP-1, preferred, 1920x0, 1.6, transform, 1"
        "eDP-2, preferred, 1920x0, 1.6, transform, 1"
        "DP-2, 1920x1080@260.00Hz, 0x0, 1"
        "DP-3, 1920x1080@260.00Hz, 0x0, 1"
      ];
      workspace = [
        "1, monitor:DP-2,      default:true"
        "1, monitor:DP-3,      default:true"
        "2, monitor:eDP-1,     default:true"
        "2, monitor:eDP-2,     default:true"
        "2, layout:dwindle"
      ];
    };
  };

  environment.sessionVariables = {
    SECLISTS = "${pkgs.seclists}/share/wordlists/seclists";
  };
}
