{
  lib,
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args:
with eriniteLib; let
  niriPackages = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system};
in
  mkModule args {
    configFn = _: {
      programs.niri = {
        enable = true;
        # package = niriPackages.niri-unstable;
        package = pkgs.niri;

        settings = lib.mkMerge [
          (import ./settings.nix args)
          # (import ./workspaces.nix args)
          (import ./binds.nix)
          (import ./rules.nix)
        ];
      };
    };
  }
