{
  lib,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "system";
  name = "keyd";

<<<<<<< HEAD
  defaultSettings = {
    main = {
      capslock = "overload(control, esc)";
    };
  };

=======
>>>>>>> origin/main
  configFn = { settings, ... }: {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
<<<<<<< HEAD
        settings = settings;
=======
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        } // settings;
>>>>>>> origin/main
      };
    };
  };
}
