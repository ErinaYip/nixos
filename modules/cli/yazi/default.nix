{
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "cli";
  name = "yazy";

  defaultSettings = import ./settings.nix;

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

        settings = settings;
        keymap = import ./keymap.nix;
      };
    };
  };
}
