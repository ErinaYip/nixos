{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    configFn = _: {
      erinite.os = {
        desktop = {
          stylix = enabled;
          theme-specialisations = enabled;
        };
      };
    };
  }
