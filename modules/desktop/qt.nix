{
  lib,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "desktop";
  name = "qt";

  configFn = { ... }: {
    qt = {
      enable = true;
      platformTheme.name = "gtk";
      style.name = "adwaita-dark";
    };
  };
}
