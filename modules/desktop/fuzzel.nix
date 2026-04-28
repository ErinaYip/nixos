{
  lib,
  eriniteLib,
  ...
} @ args:

eriniteLib.mkModule args {
  category = "desktop";
  name = "fuzzel";

  configFn = { ... }: {
    erinite.home.programs.fuzzel.enable = true;
  };
}
