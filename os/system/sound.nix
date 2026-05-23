{
  lib,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  category = "system";
  name = "sound";

  configFn = {...}: {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      wireplumber.enable = true;
    };
  };
}
