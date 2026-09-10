{
  lib,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    configFn = _: {
      wayland.windowManager.niri = {
        enable = true;

        settings = lib.mkMerge [
          (import ./settings.nix)
          (import ./binds.nix)
          (import ./rules.nix)
        ];
      };
    };
  }
