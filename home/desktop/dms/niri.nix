{
  wayland.windowManager.niri.settings = {
    binds = {
      "Mod+Space" = {
        _props.hotkey-overlay-title = "Application Launcher";
        spawn = ["dms" "ipc" "call" "spotlight" "toggle"];
      };
      "Mod+V" = {
        _props.hotkey-overlay-title = "Clipboard Manager";
        spawn = ["dms" "ipc" "call" "clipboard" "toggle"];
      };
      "Mod+M" = {
        _props.hotkey-overlay-title = "Task Manager";
        spawn = ["dms" "ipc" "call" "processlist" "focusOrToggle"];
      };
      "Mod+Comma" = {
        _props.hotkey-overlay-title = "Settings";
        spawn = ["dms" "ipc" "call" "settings" "focusOrToggle"];
      };
      # "Mod+N" = {
      #   _props.hotkey-overlay-title = "Notification Center";
      #   spawn = ["dms" "ipc" "call" "notifications" "toggle"];
      # };
      "Mod+Y" = {
        _props.hotkey-overlay-title = "Browse Wallpapers";
        spawn = ["dms" "ipc" "call" "dankdash" "wallpaper"];
      };

      "Mod+Alt+L" = {
        _props.hotkey-overlay-title = "Lock Screen";
        spawn = ["dms" "ipc" "call" "lock" "lock"];
      };

      "Mod+X" = {
        _props.hotkey-overlay-title = "Power Menu";
        spawn = ["dms" "ipc" "call" "powermenu" "toggle"];
      };

      "XF86AudioRaiseVolume" = {
        _props.allow-when-locked = true;
        spawn = ["dms" "ipc" "call" "audio" "increment" "3"];
      };
      "XF86AudioLowerVolume" = {
        _props.allow-when-locked = true;
        spawn = ["dms" "ipc" "call" "audio" "decrement" "3"];
      };
      "XF86AudioMute" = {
        _props.allow-when-locked = true;
        spawn = ["dms" "ipc" "call" "audio" "mute"];
      };

      "XF86MonBrightnessUp" = {
        _props.allow-when-locked = true;
        spawn = ["dms" "ipc" "call" "brightness" "increment" "5" ""];
      };
      "XF86MonBrightnessDown" = {
        _props.allow-when-locked = true;
        spawn = ["dms" "ipc" "call" "brightness" "decrement" "5" ""];
      };
    };

    _children = [
      {
        layer-rule._children = [
          {match._props = {namespace = "^quickshell$";};}
          {place-within-backdrop = true;}
        ];
      }
      {
        layer-rule._children = [
          {match._props = {namespace = "dms:blurwallpaper";};}
          {place-within-backdrop = true;}
        ];
      }
      {
        window-rule._children = [
          {match._props = {app-id = "^com.danklinux.dms$";};}
          {open-floating = true;}
        ];
      }
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
