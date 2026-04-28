{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:

eriniteLib.mkModule args {
  category = "system";
  name = "media";

  configFn = { ... }: {
    environment.systemPackages = with pkgs; [
      vlc
      nomacs
    ];
  };
}
