{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  namespace = ["erinite" "home"];
  category = "desktop";
  name = "fuzzel";

  configFn = _: {
    programs.fuzzel.enable = true;
  };
}
