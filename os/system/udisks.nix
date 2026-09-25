{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    services.udisks2.enable = true;
  };
}
