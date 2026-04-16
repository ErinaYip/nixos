{
  lib,
  pkgs,
  inputs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "desktop";
  name = "dms";

  imports = [ inputs.dms.homeModules.dank-material-shell ];

  configFn = { ... }: lib.mkMerge [
    {
      programs.dank-material-shell = {
        enable = true;
        quickshell.package = pkgs.quickshell;

        systemd = {
          enable = true;             # Systemd service for auto-start
          restartIfChanged = true;   # Auto-restart dms.service when dms-shell changes
        };

        enableSystemMonitoring = true;     # System monitoring widgets (dgop)
        enableVPN = false;                  # VPN management widget
        enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
        enableAudioWavelength = true;      # Audio visualizer (cava)
        enableCalendarEvents = true;       # Calendar integration (khal)
        enableClipboardPaste = true;       # Pasting from the clipboard history (wtype)
      };
    }

    (import ./hyprland.nix)
  ];
}
