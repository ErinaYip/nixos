{
  pkgs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  category = "system";
  name = "media";

  configFn = _: {
    environment.systemPackages = with pkgs; [
      vlc
      # nomacs
    ];
  };
}
