{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
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
