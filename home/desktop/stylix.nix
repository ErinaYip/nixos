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

  defaultSettings = {
    autoEnable = true;
    image = lib.mkDefault pkgs.nixos-artwork.wallpapers.catppuccin-frappe.src;

    icons = {
      enable = true;
      package = pkgs.tela-icon-theme;
      dark = "Tela-dracula-dark";
      light = "Tela-dracula-light";
    };

    targets = {
      nvf.enable = false;
      firefox.enable = false;
    };
  };

  configFn = {settings, ...}: {
    stylix = lib.mkMerge [
      settings
      {
        enable = true;
        overlays.enable = false;
      }
    ];
  };
}
