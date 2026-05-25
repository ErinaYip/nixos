{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "presets";
    name = "stylix";

    configFn = _: {
      erinite.home = {
        desktop = {
          stylix = enabled;
          theme-specialisations = enabled;
        };
      };
    };
  }
