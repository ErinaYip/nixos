{
  lib,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "cli";
  name = "starship";

  configFn = { settings, ... }: {
    erinite.home.programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      settings = {
        add_newline = true;
        # command_timeout = 1300;
        # scan_timeout = 50;
        character = {
          success_symbol = "[›](bold green) ";
          error_symbol = "[›](bold red) ";
        };
      } // settings;
    };
  };
}
