{
  inputs,
  config,
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "desktop";
  name = "hyprland";

  configFn = { settings, ... }: {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard
      grim
      slurp
    ];

    erinite.home = lib.mkMerge [
      {
        wayland.windowManager.hyprland = {
          enable = true;
          systemd.enable = false;
          settings = {} // settings;
        };

        xdg.portal = {
          enable = true;
          extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
          config = {
            hyprland.preferred = [ "hyprland" "gtk" ];
          };
        };

        services.hypridle = {
          enable = true;
            settings = {
              general = {
                after_sleep_cmd = "hyprctl dispatch dpms on";
              };
              listener = [
                {
                  timeout = 600;
                  on-timeout = "hyprctl dispatch dpms off";
                  on-resume = "hyprctl dispatch dpms on";
                }
              ];
            };
          };
        }

      (import ./settings.nix)
      (import ./binds.nix)
      (import ./rules.nix)
    ];
  };
}
