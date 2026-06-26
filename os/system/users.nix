{
  lib,
  default,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  configFn = {...}: {
    users.users.${default.username} = {
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };
}
