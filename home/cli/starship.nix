{
  pkgs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  namespace = ["erinite" "home"];
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
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      inherit settings;
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
}
