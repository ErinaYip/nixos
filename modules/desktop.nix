{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.demo.desktop.hyprland;
in {
  options.demo.desktop.hyprland = with types; {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable Hyprland.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Inject home-manager config via extraOptions
    demo.home.extraOptions.wayland = {
      windowManager = {
        hyprland = {
          enable = true;
        };
      };
    };

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