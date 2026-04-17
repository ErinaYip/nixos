{
  inputs,
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "desktop";
  name = "hyprland";

<<<<<<< HEAD
  defaultSettings = lib.mkMerge [
    (import ./binds.nix)
    (import ./rules.nix)
    (import ./settings.nix)
  ];

=======
>>>>>>> origin/main
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

    environment.localBinInPath = true;
    environment.pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];

<<<<<<< HEAD
    nix.settings.substituters = [
      "https://hyprland.cachix.org"
    ];
    nix.settings.trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];

=======
>>>>>>> origin/main
    erinite.home = {
      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
<<<<<<< HEAD
        settings = settings;
=======
        settings = lib.mkMerge [
          (import ./binds.nix)
          (import ./rules.nix)
          (import ./settings.nix)
          settings
        ];
>>>>>>> origin/main
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
    };
  };
}
