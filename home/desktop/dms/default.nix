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

    configFn = {cfg, ...}: let
      dmsPackage = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.dms-shell;
    in
      lib.mkMerge [
        {
          programs.dank-material-shell = {
            enable = true;

            settings = import ./settings.nix;
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
            inputs.home-manager.lib.hm.dag.entryAfter ["reloadSystemd"] ''
              $DRY_RUN_CMD ${dmsPackage}/bin/dms restart
            ''
          );
        }

        (import ./hyprland.nix args)
      ];
  }
