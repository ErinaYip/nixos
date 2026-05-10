{
  lib,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  category = "cli";
  name = "btop";

  configFn = {...}: {
    erinite.home.programs.btop = {
      enable = true;
      settings.theme_background = false;
    };
  };
}
