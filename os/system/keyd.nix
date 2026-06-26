{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = ["*"];
        settings.main = {
          capslock = "overload(control, esc)";
        };
      };
    };
  };
}
