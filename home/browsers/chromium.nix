{
  pkgs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  namespace = ["erinite" "home"];
  category = "browsers";
  name = "chromium";

  configFn = _: {
    home.packages = [pkgs.chromium];
  };
}
