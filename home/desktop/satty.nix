{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  namespace = ["erinite" "home"];
  category = "desktop";
  name = "satty";

  defaultSettings = {
    general = {
      early-exit = true;
      fullscreen = true;
      output-filename = "~/Pictures/Screenshots/%Y-%m-%d_%H:%M:%S.png";
    };
  };

  configFn = {settings, ...}: {
    programs.satty = {
      enable = true;
      inherit settings;
    };
  };
}
