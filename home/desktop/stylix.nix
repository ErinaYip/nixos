{
  pkgs,
  config,
  eriniteLib,
  ...
} @ args: let
  inherit (eriniteLib) recolorScript;
  telaIconThemeNames = ["Tela" "Tela-dark"];
  telaIconTheme = pkgs.tela-icon-theme.overrideAttrs (oldAttrs: {
    installPhase = ''
      runHook preInstall

      patchShebangs install.sh
      mkdir -p $out/share/icons
      ./install.sh -d $out/share/icons standard
      jdupes -l -r $out/share/icons

      runHook postInstall
    '';

    postInstall =
      recolorScript (args // {recolorOptions.whitelist = telaIconThemeNames;})
      + (oldAttrs.postInstall or "");
  });

  inherit (config.erinite) wallpapers;
  wallpaper = wallpapers.wallpapers.${wallpapers.default};
in
  with eriniteLib;
    mkModule args {
      defaultSettings = {
        fonts.sizes = {
          desktop = 12;
          applications = 12;
          # popups = 12;
          # terminal = 10;
        };

        icons = {
          enable = true;
          package = telaIconTheme;
          dark = "Tela-dark";
          light = "Tela";
        };

        opacity.popups = 0.8;

        fonts = {
          serif.name = "Noto Serif CJK SC";
          sansSerif.name = "Noto Sans CJK SC";
          monospace.name = "Maple Mono NF CN";
          emoji.name = "Noto Color Emoji";
        };

        targets = {
          # nvf = disabled;
          dank-material-shell = disabled;
          firefox = {
            profileNames = ["default"];
            colorTheme.enable = true;
          };
        };
      };

      configFn = {settings, ...}: {
        stylix =
          enabled
          // settings
          // {
            inherit (wallpaper) base16Scheme image polarity;
            overlays = disabled;
          };
      };
    }
