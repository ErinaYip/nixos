{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    configFn = _: {
      programs.denial = {
        enable = true;
      };
    };
  }
