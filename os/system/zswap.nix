{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    boot.zswap = {
      enable = true;
      compressor = "zstd";
      zpool = "zsmalloc";
      maxPoolPercent = 50;
      acceptThresholdPercent = 90;
      shrinkerEnabled = true;
    };
  };
}
