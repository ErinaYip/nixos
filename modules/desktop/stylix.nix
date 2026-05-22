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

    imports = [inputs.stylix.nixosModules.stylix];

    configFn = _: {
      stylix = {
        enable = true;
        autoEnable = true;

        polarity = "dark";
        base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

        fonts = {
          monospace = {
            package = pkgs.maple-mono.NF-CN;
            name = "Maple Mono NF CN";
          };
          sansSerif = {
            package = pkgs.noto-fonts-cjk-sans;
            name = "Noto Sans CJK SC";
          };
          serif = {
            package = pkgs.noto-fonts-cjk-serif;
            name = "Noto Serif CJK SC";
          };
          emoji = {
            package = pkgs.noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };
        };

        icons = {
          enable = true;
          package = pkgs.tela-icon-theme.overrideAttrs (oldAttrs: {
            postInstall = recolorScript args + (oldAttrs.postInstall or "");
          });
          # package = pkgs.tela-icon-theme;
          dark = "Tela-dracula-dark";
          light = "Tela-dracula-light";
        };
      };
    };
  }
