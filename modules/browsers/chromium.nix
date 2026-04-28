{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:

eriniteLib.mkModule args {
  category = "browsers";
  name = "chromium";

  configFn = { ... }: {
    environment.systemPackages = with pkgs; [
      chromium
    ];
  };
}
