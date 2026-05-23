{
  lib,
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
    namespace = ["erinite" "home"];
  category = "desktop";
  name = "dms";

  configFn = _: let
    dmsPackage = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.dms-shell;
  in
    lib.mkMerge [
      {
        programs.dank-material-shell = {
          enable = true;
          settings = import ./settings.nix;
          quickshell.package = pkgs.quickshell;

          systemd = {
            enable = true;
            restartIfChanged = true;
          };

          enableSystemMonitoring = true;
          enableVPN = false;
          enableDynamicTheming = true;
          enableAudioWavelength = true;
          enableCalendarEvents = true;
          enableClipboardPaste = true;
        };

        home.activation.restartDms = inputs.home-manager.lib.hm.dag.entryAfter ["reloadSystemd"] ''
          $DRY_RUN_CMD ${dmsPackage}/bin/dms restart
        '';
      }

      (import ./hyprland.nix {inherit lib;})
    ];
}
