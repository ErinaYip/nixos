{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
    namespace = ["erinite" "home"];
  category = "cli";
  name = "opencode";

  configFn = _: {
    programs.opencode.enable = true;
  };
}
