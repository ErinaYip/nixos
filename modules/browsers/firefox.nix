{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    category = "browsers";
    name = "firefox";

    configFn = _: {
      erinite.home.programs.firefox = {
        enable = true;
      };
    };
  }
