{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.erinite.desktop.hyprland;
in {
  options.erinite.desktop.hyprland = {
    enable = lib.erinite.mkBoolOpt false "Enable Hyprland.";
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