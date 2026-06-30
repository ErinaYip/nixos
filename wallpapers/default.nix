{
  lib,
  pkgs,
  eriniteLib,
  ...
}: let
  inherit (lib) mkOption;
  inherit (eriniteLib) mkStrOpt;
  wallpapersLib = import ./lib.nix {
    inherit lib pkgs eriniteLib;
  };
  inherit (wallpapersLib) mkWallpapers wallpaperDefinitionModule;

  default = "kurogame-olive";
  defaultWallpapers = {
    "kurogame-olive.png" = {
      url = "https://media-cdn-zspms.kurogame.com/pnswebsite/website2.0/images/1773936000000/6y9pm8iicrjyhd354y-17739965643372.png";
      hash = "sha256-wdC7ZU7KChFkyQW0B5twnpq4i1nFIovfyNEklSY973I=";
    };
  };
in {
  options.erinite.wallpapers = {
    default = mkStrOpt default "Wallpaper theme name to apply to the base configuration.";

    wallpapers = mkOption {
      type = lib.types.attrsOf wallpaperDefinitionModule;
      default = {};
      description = "Wallpaper definitions. The config value is processed with defaults, fetched images, paths, and base16 schemes.";
      apply = mkWallpapers;
    };
  };

  config.erinite.wallpapers.wallpapers = lib.mkDefault defaultWallpapers;
}
