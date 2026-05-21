{
  inputs,
  pkgs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  category = "desktop";
  name = "stylix";

  imports = [inputs.stylix.nixosModules.stylix];

  configFn = _: {
    stylix = {
      enable = true;
      autoEnable = false;

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

      opacity = {
        applications = 0.9;
        desktop = 0.9;
        terminal = 0.9;
      };

      targets = {
        gtk.enable = false;
        qt.enable = false;
      };
    };
  };
}
