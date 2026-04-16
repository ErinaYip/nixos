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
    ffuf
    feroxbuster
    seclists
    exiftool
    zsteg
    codex

    wavemon
  ];

  home.sessionVariables = {
    SECLISTS = "${pkgs.seclists}/share/wordlists/seclists";
  };
}
