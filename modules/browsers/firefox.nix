{
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "browsers";
  name = "firefox";

  configFn = { ... }: {
    environment.systemPackages = with pkgs; [
      firefox
    ];
  };
}
