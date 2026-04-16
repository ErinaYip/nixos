{
  lib,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "system";
  name = "keyd";

  defaultSettings = {
    main = {
      capslock = "overload(control, esc)";
    };
  };

  configFn = { settings, ... }: {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        settings = settings;
      };
    };
  };
}
