{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  category = "cli";
  name = "btop";

  configFn = _: {
    erinite.home.programs.btop = {
      enable = true;
      settings.theme_background = false;
    };
  };
}
