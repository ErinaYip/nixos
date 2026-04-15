{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.demo.desktop.hyprland = with lib; {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable Hyprland.";
    };
  };

  config = lib.mkIf config.demo.desktop.hyprland.enable {
    programs.hyprland.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      USE_WAYLAND = "1";
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard
      grim
      slurp
    ];
  };
}