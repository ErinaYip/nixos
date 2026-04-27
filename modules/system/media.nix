{
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "system";
  name = "media";

  configFn = { ... }: {
    environment.systemPackages = with pkgs; [
      vlc
      nomacs
    ];
  };
}
