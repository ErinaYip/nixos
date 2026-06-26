{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    configFn = _: {
      erinite.home = {
        desktop = {
          stylix = enabled;
          theme-specialisations = enabled;
        };
      };
    };
  }
