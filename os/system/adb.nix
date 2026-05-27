{
  pkgs,
  default,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  category = "system";
  name = "adb";

  configFn = _: {
    environment.systemPackages = [pkgs.android-tools];
    users.users.${default.username}.extraGroups = ["adbusers"];
  };
}
