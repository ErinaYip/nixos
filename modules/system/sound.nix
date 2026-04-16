{
  lib,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "system";
  name = "sound";

  configFn = { ... }: {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
}
