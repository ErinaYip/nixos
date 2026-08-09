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
          (import ./settings.nix args)
          (import ./binds.nix)
          (import ./rules.nix)
        ];
      };
    };
  }
