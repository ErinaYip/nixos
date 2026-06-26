{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    configFn = _: {
      erinite.home = {
        desktop = {
          gtk = enabled;
          matugen = enabled;
          qt = enabled;
        };
      };
    };
  }
