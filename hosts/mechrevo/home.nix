{ pkgs, ... }:
{
  home.packages = with pkgs;[
    cowsay
    lolcat
    cava
    tldr
    jq
    foremost
    binwalk
    john
    ffuf
    feroxbuster
    seclists
    exiftool
    zsteg
    codex
    zola
    python312Packages.dirsearch

    wavemon

    wireshark
    # bottles

    qq
    wechat
    materialgram
    vscode
    obsidian
    libreoffice
  ];

  home.sessionVariables = {
    SECLISTS = "${pkgs.seclists}/share/wordlists/seclists";
  };
}
