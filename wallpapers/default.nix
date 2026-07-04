{
  lib,
  pkgs,
  config,
  eriniteLib,
  ...
}: let
  inherit (lib) mkOption;
  inherit (eriniteLib) mkDefaultRecursive mkStrOpt;
  wallpapersLib = import ./lib.nix {
    inherit lib pkgs eriniteLib;
  };
  inherit (wallpapersLib) mkWallpapers wallpaperDefinitionModule;

  defaultTheme = "kurogame-olive";
  defaultWallpaperDefinitions = {
    "kurogame-olive.png" = {
      url = "https://media-cdn-zspms.kurogame.com/pnswebsite/website2.0/images/1773936000000/6y9pm8iicrjyhd354y-17739965643372.png";
      hash = "sha256-wdC7ZU7KChFkyQW0B5twnpq4i1nFIovfyNEklSY973I=";
    };
  };
in {
  options.erinite.wallpapers = {
    default = mkStrOpt defaultTheme "Wallpaper theme name to apply to the base configuration.";

    definitions = mkOption {
      type = lib.types.attrsOf wallpaperDefinitionModule;
      default = {};
      description = "Raw wallpaper definitions used to generate wallpaper themes.";
    };

    wallpapers = mkOption {
      type = lib.types.attrsOf lib.types.anything;
      description = "Processed wallpaper themes with fetched images, paths, and base16 schemes.";
    };
  };

  config.erinite.wallpapers = {
    definitions = mkDefaultRecursive defaultWallpaperDefinitions;
    wallpapers = mkWallpapers config.erinite.wallpapers.definitions;
  };
}
