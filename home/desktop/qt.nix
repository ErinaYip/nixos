{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    qt = {
      enable = true;
      platformTheme.name = "gtk";
      style.name = "adwaita-dark";
    };
  };
}
