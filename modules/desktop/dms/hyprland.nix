{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "float on, match:class ^(org.quickshell)$"
    ];

    layerrule = [
      "no_anim on, match:namespace ^(dms)$"
    ];

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
    };

    env = [
      "QT_QPA_PLATFORM,wayland"
      "ELECTRON_OZONE_PLATFORM_HINT,auto"
      "QT_QPA_PLATFORMTHEME,gtk3"
      "QT_QPA_PLATFORMTHEME_QT6,gtk3"
    ];
  };

  wayland.windowManager.hyprland.settings.bind = [
    "$mod, space, exec, dms ipc call spotlight toggle"
    "$mod, v,     exec, dms ipc call clipboard toggle"
    "$mod, m,     exec, dms ipc call processlist focusOrToggle"
    "$mod, comma, exec, dms ipc call settings focusOrToggle"
    "$mod, n,     exec, dms ipc call notifications toggle"
    "$mod, y,     exec, dms ipc call dankdash wallpaper"
    "$mod, tab,   exec, dms ipc call hypr toggleOverview"

    "$mod ALT, l, exec, dms ipc call lock lock"
  ];

  wayland.windowManager.hyprland.settings.bindel = [
    ", XF86AudioRaiseVolume,  exec, dms ipc call audio increment 3"
    ", XF86AudioLowerVolume,  exec, dms ipc call audio decrement 3"
    ", XF86AudioMute,         exec, dms ipc call audio mute"
    ", XF86MonBrightnessUp,   exec, dms ipc call brightness increment 5"
    ", XF86MonBrightnessDown, exec, dms ipc call brightness decrement 5"
  ];

  services.hypridle = {
    settings = {
      general.lock_cmd = "dms ipc call lock lock";
      listener = [
        {
          timeout = 300;
          on-timeout = "dms ipc call lock lock";
        }
      ];
    };
  };
}

