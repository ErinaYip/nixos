{
  lib,
  pkgs,
  hostName,
  eriniteLib,
  ...
} @ args: let
  inherit (builtins) elemAt listToAttrs;
in
  with eriniteLib;
    mkModule args {
      namespace = ["erinite" "home"];
      category = "cli";
      name = "zsh";

      opts = {
        aliases = mkAttrOpt lib.types.str {} "Shell aliases to add to zsh.";
      };

      configFn = {cfg, ...}: {
        home.packages = [pkgs.any-nix-shell];

        programs.zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          history.size = 10000;

          shellAliases =
            listToAttrs (map (cmd: {
                name = "sn${elemAt cmd 0}";
                value = "sudo nixos-rebuild ${elemAt cmd 1} --flake .#${hostName}";
              }) [
                ["s" "switch"]
                ["b" "boot"]
                ["t" "test"]
                ["u" "build"]
              ])
            // cfg.aliases;

          initContent = ''
            ${builtins.readFile ./init.zsh}
            ${builtins.readFile ./fzf-settings.zsh}
            ${builtins.readFile ./fzf.zsh}
          '';
        };
      };
    }
