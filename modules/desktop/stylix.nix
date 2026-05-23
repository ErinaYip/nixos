{
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    category = "desktop";
    name = "stylix";

    imports = [
      inputs.stylix.nixosModules.default
    ];

    configFn = _: {
      home-manager.sharedModules = [
        {stylix.overlays.enable = false;}
      ];

      stylix = {
        enable = true;
      };

      erinite.home.stylix = {
        enable = true;
        autoEnable = true;

        targets = {
          nvf.enable = false;
        };

        icons = {
          enable = true;
          # package = pkgs.tela-icon-theme.overrideAttrs (oldAttrs: {
          #   postInstall = recolorScript args + (oldAttrs.postInstall or "");
          # });
          package = pkgs.tela-icon-theme;
          dark = "Tela-dracula-dark";
          light = "Tela-dracula-light";
        };
      };
    };
  }
