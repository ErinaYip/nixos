{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    programs.fuzzel = {
      enable = true;
      settings = {
        border.width = 3;
      };
    };
  };
}
