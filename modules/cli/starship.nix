{
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "cli";
  name = "starship";

<<<<<<< HEAD
  defaultSettings = {
    add_newline = true;
    character = {
      success_symbol = "[›](bold green) ";
      error_symbol = "[›](bold red) ";
    };
  };

=======
>>>>>>> origin/main
  configFn = { settings, ... }: {
    erinite.home = {
      programs.starship = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
<<<<<<< HEAD
        settings = settings;
=======
        settings = {
          add_newline = true;
          character = {
            success_symbol = "[›](bold green) ";
            error_symbol = "[›](bold red) ";
          };
        } // settings;
>>>>>>> origin/main
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
