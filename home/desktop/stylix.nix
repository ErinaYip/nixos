{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
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
        nvf = disabled;
        dank-material-shell = disabled;
        firefox = {
          profileNames = ["default"];
          colorTheme.enable = true;
        };
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
