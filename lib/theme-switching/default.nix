{
  lib,
  pkgs,
}: let
  inherit (lib) attrNames attrValues concatMapStringsSep escapeShellArg;

  replaceScript = {
    name,
    src,
    replacements,
    runtimeInputs ? [],
  }: let
    replaceNames = map (name: "@${name}@") (attrNames replacements);
    replaceValues = map toString (attrValues replacements);
  in
    pkgs.writeShellApplication {
      inherit name runtimeInputs;
      text = builtins.replaceStrings replaceNames replaceValues (builtins.readFile src);
    };
in {
  mkHomePrograms = {
    dmsPackage,
    themesFile,
    wallpaperCase,
  }: let
    themeSwitch = replaceScript {
      name = "erinite-theme-switch";
      src = ./switch-theme.sh;
      runtimeInputs = with pkgs; [
        coreutils
        gnugrep
        dmsPackage
        systemd
      ];
      replacements = {
        inherit themesFile;
      };
    };

    wallpaperHook = replaceScript {
      name = "erinite-theme-switch-from-wallpaper";
      src = ./switch-from-wallpaper.sh;
      runtimeInputs = with pkgs; [
        coreutils
      ];
      replacements = {
        inherit wallpaperCase;
        themeSwitch = "${themeSwitch}";
      };
    };
  in {
    inherit themeSwitch wallpaperHook;

    package = pkgs.symlinkJoin {
      name = "erinite-theme-switch";
      paths = [
        themeSwitch
        wallpaperHook
      ];
    };
  };

  mkSystemSwitchScript = {themeNames}: let
    themeCasePattern = concatMapStringsSep "|" escapeShellArg themeNames;
  in
    replaceScript {
      name = "erinite-theme-switch-system";
      src = ./switch-system-theme.sh;
      replacements = {
        inherit themeCasePattern;
      };
    };
}
