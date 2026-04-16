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

    wavemon

    wireshark
    bottles
  ];

  home.sessionVariables = {
    SECLISTS = "${pkgs.seclists}/share/wordlists/seclists";
  };
}
