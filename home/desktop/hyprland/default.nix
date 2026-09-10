{
  lib,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
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
    };
  }
