{
  default,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    users.users.${default.username} = {
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };
}
