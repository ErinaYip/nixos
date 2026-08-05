{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    configFn = _: {
      erinite.home = {
        desktop = {
          stylix = enabled;
          matugen = enabled;
          theme-specialisations = enabled;
        };
      };
    };
  }
