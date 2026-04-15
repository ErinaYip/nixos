{
  config,
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "desktop";
  name = "hyprland";

  configFn = { ... }: {
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    environment.systemPackages = with pkgs; [
      wl-clipboard
      grim
      slurp
    ];
  };
}