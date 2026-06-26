{
  pkgs,
  default,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    environment.systemPackages = [pkgs.android-tools];
    users.users.${default.username}.extraGroups = ["adbusers"];
  };
}
