{
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "cli";
  name = "bat";

  configFn = { ... }: {
    programs = {
      bat = {
        enable = true;
        settings = {
          pager = "less -FR";
        };
        extraPackages = with pkgs.bat-extras; [
          batman
          batpipe
          batgrep
          batdiff
        ];
      };
    };

    environment.shellAliases = {
      cat = "batpipe";
      less = "bat";
      man = "batman";
    };
  };
}
