{
  lib,
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "desktop";
    name = "dms";

    opts = {
      restartIfChanged = mkBoolOpt false "Whether to auto restart dms if configurations changed.";
      session = mkOpt lib.types.attrs {} "Dms session state settings.";
    };

    defaultSettings = import ./settings.nix;

    configFn = {
      cfg,
      settings,
      ...
    }: let
      dmsPackage =
        inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.dms-shell.overrideAttrs
        (old: {
          eriniteThemeLockPatch = "1";
          nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.perl];
          postInstall =
            old.postInstall
            + ''
              sessionData=$out/share/quickshell/dms/Common/SessionData.qml
              chmod u+w "$sessionData" "$(dirname "$sessionData")"

              perl -0pi -e 's|    function setWallpaper\(imagePath\) \{\n        wallpaperPath = imagePath;|    function setWallpaper(imagePath) {\n        if (themeSwitchLockFile.loaded) {\n            ToastService.showInfo(I18n.tr("Theme switch in progress"), I18n.tr("Please wait for the current theme switch to finish."));\n            return;\n        }\n\n        wallpaperPath = imagePath;|' "$sessionData"

              perl -0pi -e 's|    Process \{\n        id: sessionWritableCheckProcess|    FileView {\n        id: themeSwitchLockFile\n\n        path: isGreeterMode ? "" : StandardPaths.writableLocation(StandardPaths.GenericStateLocation) + "/DankMaterialShell/erinite-theme-switch.lock"\n        blockLoading: true\n        blockWrites: false\n        watchChanges: !isGreeterMode\n        printErrors: false\n    }\n\n    Process {\n        id: sessionWritableCheckProcess|' "$sessionData"

              grep -q themeSwitchLockFile "$sessionData"
            '';
        });
    in
      lib.mkMerge [
        {
          programs.dank-material-shell = {
            enable = true;
            package = dmsPackage;

            inherit settings;
            inherit (cfg) session;

            systemd = {
              enable = true;
              inherit (cfg) restartIfChanged;
            };

            enableSystemMonitoring = true;
            enableVPN = false;
            enableDynamicTheming = true;
            enableAudioWavelength = true;
            enableCalendarEvents = true;
            enableClipboardPaste = true;
          };

          home.activation.restartDms = lib.mkIf cfg.restartIfChanged (
            inputs.home-manager.lib.hm.dag.entryBetween ["onFilesChange" "reloadSystemd"] ["linkGeneration"] ''
              ${dmsPackage}/bin/dms restart
            ''
          );
        }

        (import ./hyprland.nix args)
      ];
  }
