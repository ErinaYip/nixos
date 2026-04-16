{
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "cli";
  name = "starship";

  configFn = { settings, ... }: {
    erinite.home = {
      programs.starship = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
        settings = {
          add_newline = true;
          character = {
            success_symbol = "[›](bold green) ";
            error_symbol = "[›](bold red) ";
          };
        } // settings;
      };

      programs.yazi = {
        plugins = {
          "starship" = pkgs.yaziPlugins.starship;
        };
        initLua = ''
          require("starship"):setup()
        '';
      };
    };
  };
}
