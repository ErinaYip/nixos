{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  category = "programs";
  name = "localsend";

  configFn = _: {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
