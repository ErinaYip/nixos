{
  lib,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "desktop";
  name = "fuzzel";

  configFn = { ... }: {
    programs.fuzzel.enable = true;
  };
}
