{
  inputs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    category = "desktop";
    name = "stylix";

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
        // {homeManagerIntegration.autoImport = false;};
    };
  }
