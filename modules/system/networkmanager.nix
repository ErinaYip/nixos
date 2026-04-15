{
  lib,
  default,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "system";
  name = "networkmanager";

  configFn = { ... }: {
    networking.hostName = "nixos";
    users.users.${default.username}.extraGroups = [ "networkmanager" ];
  };
}
