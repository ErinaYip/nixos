{
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "cli";
<<<<<<< HEAD
  name = "yazi";

  defaultSettings = import ./settings.nix;
=======
  name = "yazy";
>>>>>>> origin/main

  configFn = { settings, ... }: {
    erinite.home = {
      home.packages = with pkgs; [
        fzf
        fd
        ripgrep
        zoxide
      ];

      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        plugins = {
          "smart-enter" = pkgs.yaziPlugins.smart-enter;
        };

<<<<<<< HEAD
        settings = settings;
=======
        settings = import ./settings.nix // settings;
>>>>>>> origin/main
        keymap = import ./keymap.nix;
      };
    };
  };
}
