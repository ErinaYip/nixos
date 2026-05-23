{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  namespace = ["erinite" "home"];
  category = "desktop";
  name = "stylix";

  configFn = _: {
    stylix = {
      enable = true;
      autoEnable = true;
      image = lib.mkDefault pkgs.nixos-artwork.wallpapers.wallpaper-catppuccin-frappe.src;

      targets = {
        nvf.enable = false;
        firefox.enable = false;
      };
    };
  };
}
