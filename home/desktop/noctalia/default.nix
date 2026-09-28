{
  lib,
  config,
  eriniteLib,
  ...
} @ args: let
  inherit (config.erinite) wallpapers;
  wallpaper = wallpapers.wallpapers.${wallpapers.default};
in
  eriniteLib.mkModule args {
    configFn = {settings, ...}:
      lib.mkMerge [
        {
          programs.noctalia = {
            enable = true;
            systemd.enable = true;
            settings = lib.mkMerge [
              (import ./settings.nix {inherit wallpaper;})
              (import ./bars.nix)
              settings
            ];
          };
        }
        (import ./hyprland.nix {inherit lib;})
      ];
  }
