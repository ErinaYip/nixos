let
  mkWindowRule = match: properties:
    {
      matches = [match];
    }
    // properties;
in {
  programs.niri.settings = {
    binds = {
      "Mod+Space" = {
        hotkey-overlay.title = "Application Launcher";
        action.spawn = ["dms" "ipc" "call" "spotlight" "toggle"];
      };
      "Mod+V" = {
        hotkey-overlay.title = "Clipboard Manager";
        action.spawn = ["dms" "ipc" "call" "clipboard" "toggle"];
      };
      "Mod+M" = {
        hotkey-overlay.title = "Task Manager";
        action.spawn = ["dms" "ipc" "call" "processlist" "focusOrToggle"];
      };
      "Mod+Comma" = {
        hotkey-overlay.title = "Settings";
        action.spawn = ["dms" "ipc" "call" "settings" "focusOrToggle"];
      };
      # "Mod+N" = {
      #   hotkey-overlay.title = "Notification Center";
      #   action.spawn = ["dms" "ipc" "call" "notifications" "toggle"];
      # };
      "Mod+Y" = {
        hotkey-overlay.title = "Browse Wallpapers";
        action.spawn = ["dms" "ipc" "call" "dankdash" "wallpaper"];
      };

      "Mod+Alt+L" = {
        hotkey-overlay.title = "Lock Screen";
        action.spawn = ["dms" "ipc" "call" "lock" "lock"];
      };

      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action.spawn = ["dms" "ipc" "call" "audio" "increment" "3"];
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action.spawn = ["dms" "ipc" "call" "audio" "decrement" "3"];
      };
      "XF86AudioMute" = {
        allow-when-locked = true;
        action.spawn = ["dms" "ipc" "call" "audio" "mute"];
      };

      "XF86MonBrightnessUp" = {
        allow-when-locked = true;
        action.spawn = ["dms" "ipc" "call" "brightness" "increment" "5" ""];
      };
      "XF86MonBrightnessDown" = {
        allow-when-locked = true;
        action.spawn = ["dms" "ipc" "call" "brightness" "decrement" "5" ""];
      };
    };

    layer-rules = [
      (mkWindowRule
        {namespace = "^quickshell$";}
        {place-within-backdrop = true;})

      (mkWindowRule
        {namespace = "dms:blurwallpaper";}
        {place-within-backdrop = true;})
    ];

    window-rules = [
      (mkWindowRule
        {app-id = "^org.quickshell$";}
        {open-floating = true;})
    ];

    environment = {
      XDG_CURRENT_DESKTOP = "niri";
      QT_QPA_PLATFORM = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      QT_QPA_PLATFORMTHEME = "gtk3";
      QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
    };
  };
}
