{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    category = "cli";
    name = "opencode";

    configFn = _: {
      erinite.home.programs.opencode = {
        enable = true;
      };
    };
  }
