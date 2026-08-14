{
  lib,
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args: let
  niriPackages = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system};
in
  with eriniteLib;
    mkModule args {
      configFn = _: {
        programs.niri = {
          enable = true;
          package = niriPackages.niri-unstable;

          settings = lib.mkMerge [
            (import ./settings.nix args)
            (import ./workspaces.nix args)
            (import ./binds.nix)
            (import ./rules.nix)
          ];
        };
      };
    }
