{
  inputs,
  config,
  eriniteLib,
  ...
} @ args: let
  inherit (config.erinite) wallpapers;
  wallpaper = wallpapers.wallpapers.${wallpapers.default};
in
  with eriniteLib;
    mkModule args {
      imports = [inputs.stylix.nixosModules.default];

      defaultSettings = {
        fonts = {
          serif.name = "Noto Serif CJK SC";
          sansSerif.name = "Noto Sans CJK SC";
          monospace.name = "Maple Mono NF CN";
          emoji.name = "Noto Color Emoji";
        };

        targets.kmscon.enable = false;
      };

      configFn = {settings, ...}: {
        stylix =
          enabled
          // settings
          // {
            inherit (wallpaper) base16Scheme image polarity;
            homeManagerIntegration.autoImport = false;
          };
      };
    }
