{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:

with eriniteLib; mkModule args {
  category = "desktop";
  name = "hyprland";

  opts = {
    grass = mkBoolOpt false "Whether to enable hyprgrass";
  };

  defaultSettings = lib.mkMerge [
    (import ./binds.nix)
    (import ./rules.nix)
    (import ./settings.nix)
    (import ./dynamic-cursors.nix)
    (import ./grass.nix)
  ];

  configFn = { settings, cfg, ... }: {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      package = mkInputPkga "hyprland";
      portalPackage = mkInputPkgb "hyprland" "xdg-desktop-portal-hyprland";
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

    nix.settings.substituters = [
      "https://hyprland.cachix.org"
    ];
    nix.settings.trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];

    erinite.home = {
      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
        settings = settings;
        package = mkInputPkga "hyprland";
        plugins = [
          # (mkInputPkga "hypr-dynamic-cursors")
          (lib.mkIf cfg.grass (mkInputPkga "hyprgrass"))
        ];
      };

      xdg.portal = {
        enable = true;
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
