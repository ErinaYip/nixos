{
  pkgs,
  lib,
  eriniteLib,
  ...
} @ args:
with eriniteLib; let
  obsidianAssets = ../../../assets/obsidian;
  plugins = import ./plugins.nix {inherit pkgs obsidianAssets;};
  themes = import ./themes.nix {inherit lib obsidianAssets;};
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
        package = pkgs.obsidian;
        defaultSettings = import ./settings.nix {inherit plugins themes;};

        inherit (cfg) vaults;
      };
    };
  }
