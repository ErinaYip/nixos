{
  lib,
  eriniteLib,
  ...
} @ args:

eriniteLib.mkModule args {
  category = "system";
  name = "keyd";

  configFn = { ... }: {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        settings.main = {
          capslock = "overload(control, esc)";
        };
      };
    };
  };
}
