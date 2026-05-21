{lib}: let
  raw = lib.generators.mkLuaInline;
in {
  wayland.windowManager.hyprland.settings = {
    window_rule = [
      {
        name = "float-quickshell";
        match.class = "^(org.quickshell)$";
        float = true;
      }
    ];

    layer_rule = [
      {
        name = "no-anim-dms";
        match.namespace = "^(dms)$";
        no_anim = true;
      }
    ];

    config.misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
    };

    env = [
      {_args = ["QT_QPA_PLATFORM" "wayland"];}
      {_args = ["ELECTRON_OZONE_PLATFORM_HINT" "auto"];}
      {_args = ["QT_QPA_PLATFORMTHEME" "gtk3"];}
      {_args = ["QT_QPA_PLATFORMTHEME_QT6" "gtk3"];}
    ];
  };

  wayland.windowManager.hyprland.settings.bind = [
    {
      _args = ["SUPER + space" (raw ''hl.dsp.exec_cmd("dms ipc call spotlight toggle")'')];
    }
    {
      _args = ["SUPER + v" (raw ''hl.dsp.exec_cmd("dms ipc call clipboard toggle")'')];
    }
    {
      _args = ["SUPER + m" (raw ''hl.dsp.exec_cmd("dms ipc call processlist focusOrToggle")'')];
    }
    {
      _args = ["SUPER + comma" (raw ''hl.dsp.exec_cmd("dms ipc call settings focusOrToggle")'')];
    }
    {
      _args = ["SUPER + n" (raw ''hl.dsp.exec_cmd("dms ipc call notifications toggle")'')];
    }
    {
      _args = ["SUPER + y" (raw ''hl.dsp.exec_cmd("dms ipc call dankdash wallpaper")'')];
    }
    {
      _args = ["SUPER + tab" (raw ''hl.dsp.exec_cmd("dms ipc call hypr toggleOverview")'')];
    }

    {
      _args = ["SUPER + ALT + l" (raw ''hl.dsp.exec_cmd("dms ipc call lock lock")'')];
    }
    {
      _args = ["XF86AudioRaiseVolume" (raw ''hl.dsp.exec_cmd("dms ipc call audio increment 3")'') {locked = true; repeating = true;}];
    }
    {
      _args = ["XF86AudioLowerVolume" (raw ''hl.dsp.exec_cmd("dms ipc call audio decrement 3")'') {locked = true; repeating = true;}];
    }
    {
      _args = ["XF86AudioMute" (raw ''hl.dsp.exec_cmd("dms ipc call audio mute")'') {locked = true; repeating = true;}];
    }
    {
      _args = ["XF86MonBrightnessUp" (raw ''hl.dsp.exec_cmd("dms ipc call brightness increment 5")'') {locked = true; repeating = true;}];
    }
    {
      _args = ["XF86MonBrightnessDown" (raw ''hl.dsp.exec_cmd("dms ipc call brightness decrement 5")'') {locked = true; repeating = true;}];
    }
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
