{
  lib,
  default,
  eriniteLib,
  ...
} @ args:

eriniteLib.mkModule args {
  category = "system";
  name = "users";

  configFn = { ... }: {
    users.users.${default.username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
}
