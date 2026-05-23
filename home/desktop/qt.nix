{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  namespace = ["erinite" "home"];
  category = "desktop";
  name = "qt";

  configFn = _: {
    qt = {
      enable = true;
      platformTheme.name = "gtk";
      style.name = "adwaita-dark";
    };
  };
}
