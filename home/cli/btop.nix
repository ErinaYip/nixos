{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    programs.btop = {
      enable = true;
      settings.theme_background = false;
    };
  };
}
