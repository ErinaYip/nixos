{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.demo.desktop.hyprland;
in {
  options.demo.desktop.hyprland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprland.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    environment.systemPackages = with pkgs; [
      wl-clipboard
      grim
      slurp
    ];
  };
}