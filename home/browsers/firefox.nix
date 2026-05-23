{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  namespace = ["erinite" "home"];
  category = "browsers";
  name = "firefox";

  configFn = _: {
    programs.firefox.enable = true;
  };
}
