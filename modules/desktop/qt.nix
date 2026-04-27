{
  lib,
  eriniteLib,
  ...
} @ args:

eriniteLib.mkModule args {
  category = "desktop";
  name = "qt";

  configFn = { ... }: {
    erinite.home.qt = {
      enable = true;
      platformTheme.name = "gtk";
      style.name = "adwaita-dark";
    };
  };
}
