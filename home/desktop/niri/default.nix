{
  lib,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    configFn = _: {
      programs.niri = {
        enable = true;

        settings = lib.mkMerge [
          (import ./binds.nix)
          (import ./rules.nix)
          (import ./settings.nix)
        ];
      };
    };
  }
