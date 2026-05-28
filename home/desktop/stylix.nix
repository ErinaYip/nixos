{
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
      fonts.sizes = {
        desktop = 12;
        applications = 12;
        # popups = 12;
        # terminal = 10;
      };

      icons = {
        enable = true;
        package = pkgs.tela-icon-theme;
        dark = "Tela-dracula-dark";
        light = "Tela-dracula-light";
      };

      fonts = {
        serif.name = "Noto Serif CJK SC";
        sansSerif.name = "Noto Sans CJK SC";
        monospace.name = "Maple Mono NF CN";
        emoji.name = "Noto Color Emoji";
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
      stylix = enabled // settings;
    };
  }
