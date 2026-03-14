{ lib, osConfig, ... }: {
  imports = [
    ./settings.nix
    ./binds.nix
    ./rules.nix
    ./hypridle.nix
  ];

  wayland.windowManager.hyprland = {
    enable = lib.mkIf osConfig.programs.hyprland.enable true;
    xwayland.enable = true;
  };
}
