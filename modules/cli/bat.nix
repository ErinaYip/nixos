{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:

with eriniteLib; mkModule args {
  category = "cli";
  name = "bat";

  configFn = { ... }: lib.mkMerge [
    {
      programs = {
        bat = {
          enable = true;
          extraPackages = with pkgs.bat-extras; [
            batman
            batpipe
            batgrep
            batdiff
          ];
        };
      };
    }

    (mkShellAliases {
      aliases = {
        cat = "batpipe";
        less = "bat";
        man = "batman";
      };
      shells = [ "zsh" ];
    })
  ];
}
