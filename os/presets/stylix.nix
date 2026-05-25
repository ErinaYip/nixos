{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    category = "presets";
    name = "stylix";

    configFn = _: {
      erinite = {
        desktop = {
          stylix = enabled;
          theme-specialisations = enabled;
        };
      };
    };
  }
