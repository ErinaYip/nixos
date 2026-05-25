{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "presets";
    name = "matugen";

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
