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
        package = null;
        portalPackage = null;
        systemd.enable = false;
        settings = lib.mkMerge [
          (import ./binds.nix {inherit lib;})
          (import ./rules.nix)
          (import ./settings.nix)
          (import ./dynamic-cursors.nix)
        ];

        plugins = [
          (mkInputPkga "hypr-dynamic-cursors")
        ];
      };
    };
  }
