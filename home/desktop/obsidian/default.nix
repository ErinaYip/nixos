{
  pkgs,
  lib,
  eriniteLib,
  ...
} @ args:
with eriniteLib; let
  plugins = import ./plugins.nix {inherit pkgs;};
  themes = import ./themes.nix {inherit pkgs;};
in
  mkModule args {
    opts = {
      vaults =
        mkOpt
        (lib.types.attrsOf (lib.types.submodule {
          options = {
            target = lib.mkOption {
              type = lib.types.str;
              description = "Vault path relative to the home directory.";
            };
          };
        }))
        {}
        "Obsidian vaults to configure.";
    };

    configFn = {cfg, ...}: {
      programs.obsidian = {
        enable = true;
        defaultSettings = import ./settings.nix {inherit plugins themes;};

        inherit (cfg) vaults;
      };
    };
  }
