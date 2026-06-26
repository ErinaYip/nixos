{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
