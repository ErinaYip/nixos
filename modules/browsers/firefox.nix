{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:

eriniteLib.mkModule args {
  category = "browsers";
  name = "firefox";

  configFn = { ... }: {
    environment.systemPackages = with pkgs; [
      firefox
    ];
  };
}
