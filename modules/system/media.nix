{
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "system";
  name = "meida";

  configFn = { ... }: {
    environment.systemPackages = with pkgs; [
      vlc
      nomacs
    ];
  };
}
