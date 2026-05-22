{
  lib,
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  category = "desktop";
  name = "dms";

  configFn = {...}: {
    home-manager.sharedModules = [
      inputs.dms.homeModules.dank-material-shell
    ];

    environment.systemPackages = with pkgs; [
      pywalfox-native
    ];

    erinite.home = lib.mkMerge [
      {
        programs.dank-material-shell = {
          enable = true;
          settings = import ./settings.nix;
          quickshell.package = pkgs.quickshell;

          systemd = {
            enable = true; # Systemd service for auto-start
            restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
          };

          enableSystemMonitoring = true; # System monitoring widgets (dgop)
          enableVPN = false; # VPN management widget
          enableDynamicTheming = true; # Wallpaper-based theming (matugen)
          enableAudioWavelength = true; # Audio visualizer (cava)
          enableCalendarEvents = true; # Calendar integration (khal)
          enableClipboardPaste = true; # Pasting from the clipboard history (wtype)
        };
      }

      (import ./hyprland.nix {inherit lib;})
      # (import ./templates.nix)
    ];
  };
}
