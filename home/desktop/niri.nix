{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    xwayland-satellite
    niri
  ];
}
