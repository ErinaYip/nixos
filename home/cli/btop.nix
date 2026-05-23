{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
    namespace = ["erinite" "home"];
  category = "cli";
  name = "btop";

  configFn = _: {
    programs.btop = {
      enable = true;
      settings.theme_background = false;
    };
  };
}
