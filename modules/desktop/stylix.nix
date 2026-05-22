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

    configFn = _: {
      home-manager.sharedModules = [
        inputs.stylix.homeModules.default
        {stylix.overlays.enable = false;}
      ];

      erinite.home.stylix = {
        enable = true;
        autoEnable = true;

        targets = {
          neovim.enable = false;
          nvf.enable = false;
        };

        # fonts = {
        #   monospace = {
        #     package = pkgs.maple-mono.NF-CN;
        #     name = "Maple Mono NF CN";
        #   };
        #   sansSerif = {
        #     package = pkgs.source-han-sans;
        #     name = "Source Han Sans SC";
        #   };
        #   serif = {
        #     package = pkgs.source-han-serif;
        #     name = "Source Han Serif SC";
        #   };
        #   emoji = {
        #     package = pkgs.noto-fonts-color-emoji;
        #     name = "Noto Color Emoji";
        #   };
        # };

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
