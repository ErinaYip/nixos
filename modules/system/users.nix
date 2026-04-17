{
  lib,
  default,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "system";
  name = "users";

  configFn = { ... }: {
    users.users.${default.username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/main
