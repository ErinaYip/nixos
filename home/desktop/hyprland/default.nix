{
  lib,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "desktop";
    name = "hyprland";

    configFn = _: {
      wayland.windowManager.hyprland = {
        enable = true;
        configType = "lua";
        systemd.enable = false;
        settings = lib.mkMerge [
          (import ./binds.nix {inherit lib;})
          (import ./rules.nix)
          (import ./settings.nix)
          (import ./dynamic-cursors.nix)
        ];

        package = mkInputPkga "hyprland";
        plugins = [
          (mkInputPkga "hypr-dynamic-cursors")
        ];
      };

      xdg.portal = {
        enable = true;
        config.hyprland.preferred = ["hyprland" "gtk"];
      };

      services.hypridle = {
        enable = true;
        settings = {
          general.after_sleep_cmd = "hyprctl dispatch dpms on";
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
  }
