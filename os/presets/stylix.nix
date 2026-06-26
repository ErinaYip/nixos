{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    configFn = _: {
      erinite = {
        desktop = {
          stylix = enabled;
          theme-specialisations = enabled;
        };
      };
    };
  }
