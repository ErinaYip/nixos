{
  pkgs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      x11.enable = true;
      name = "Bibata-Modern-Ice";
      size = 24;
      package = pkgs.bibata-cursors;
    };
  };
}
