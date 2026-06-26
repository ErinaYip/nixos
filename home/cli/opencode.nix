{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    programs.opencode.enable = true;
  };
}
