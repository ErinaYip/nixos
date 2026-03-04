{ inputs, pkgs, lib, osConfig, ... }: {
  imports = [
    ./settings.nix
    ./binds.nix
    ./rules.nix
    ./hypridle.nix
  ];

  wayland.windowManager.hyprland = {
    enable = lib.mkIf osConfig.programs.hyprland.enable true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
}
