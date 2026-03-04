{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    qq
    wechat
    chromium
    firefox
    pywalfox-native
  ];
}
