{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "games";
    name = "prismlauncher";

    configFn = _: {
      programs.prismlauncher = {
        enable = true;
        settings = {
          MinMemAlloc = 512;
          MaxMemAlloc = 8192;
          Language = "zh";
          EnableFeralGamemode = true;
          UseDiscreteGpu = true;
        };
      };
    };
  }
