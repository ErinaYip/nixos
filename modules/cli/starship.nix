{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  category = "cli";
  name = "starship";

  defaultSettings = {
    add_newline = true;
    character = {
      success_symbol = "[›](bold green) ";
      error_symbol = "[›](bold red) ";
    };
  };

  configFn = {settings, ...}: {
    erinite.home = {
      programs.starship = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
        settings = settings;
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
