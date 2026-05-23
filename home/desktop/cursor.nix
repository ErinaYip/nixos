{pkgs, eriniteLib, ...} @ args:
eriniteLib.mkModule args {
    namespace = ["erinite" "home"];
  category = "desktop";
  name = "cursor";

  configFn = _: {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Bibata-Modern-Ice";
      size = 24;
      package = pkgs.bibata-cursors;
    };
  };
}
