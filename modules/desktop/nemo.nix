{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  category = "desktop";
  name = "nemo";

  configFn = {...}: {
    environment.systemPackages = with pkgs; [
      nemo-with-extensions
      nemo-fileroller
      gvfs
      file-roller
    ];
  };
}
