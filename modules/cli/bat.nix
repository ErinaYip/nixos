{
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "cli";
  name = "bat";

  configFn = { ... }: let
    shellAliases = {
      cat = "batpipe";
      less = "bat";
      man = "batman";
    };
  in {
    programs = {
      bat = {
        enable = true;
        config = {
          pager = "less -FR";
        };
        extraPackages = with pkgs.bat-extras; [
          batman
          batpipe
          batgrep
          batdiff
        ];
      };
      zsh.shellAliases = shellAliases;
      fish.shellAliases = shellAliases;
    };
  };
}
