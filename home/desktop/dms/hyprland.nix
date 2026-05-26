{lib, ...}: let
  raw = lib.generators.mkLuaInline;

  bind = mods: dispatcher: {
    _args = [
      mods
      (raw dispatcher)
    ];
  };

  bindWithOpts = mods: dispatcher: opts: {
    _args = [
      mods
      (raw dispatcher)
      opts
    ];
  };
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
    (bind "SUPER + space" ''hl.dsp.exec_cmd("dms ipc call spotlight toggle")'')
    (bind "SUPER + v" ''hl.dsp.exec_cmd("dms ipc call clipboard toggle")'')
    (bind "SUPER + m" ''hl.dsp.exec_cmd("dms ipc call processlist focusOrToggle")'')
    (bind "SUPER + comma" ''hl.dsp.exec_cmd("dms ipc call settings focusOrToggle")'')
    # (bind "SUPER + n" ''hl.dsp.exec_cmd("dms ipc call notifications toggle")'')
    # (bind "SUPER + y" ''hl.dsp.exec_cmd("dms ipc call dankdash wallpaper")'')
    (bind "SUPER + tab" ''hl.dsp.exec_cmd("dms ipc call hypr toggleOverview")'')

    (bind "SUPER + ALT + l" ''hl.dsp.exec_cmd("dms ipc call lock lock")'')

    (bindWithOpts "XF86AudioRaiseVolume" ''hl.dsp.exec_cmd("dms ipc call audio increment 3")'' {
      locked = true;
      repeating = true;
    })
    (bindWithOpts "XF86AudioLowerVolume" ''hl.dsp.exec_cmd("dms ipc call audio decrement 3")'' {
      locked = true;
      repeating = true;
    })
    (bindWithOpts "XF86AudioMute" ''hl.dsp.exec_cmd("dms ipc call audio mute")'' {
      locked = true;
      repeating = true;
    })
    (bindWithOpts "XF86MonBrightnessUp" ''hl.dsp.exec_cmd("dms ipc call brightness increment 5")'' {
      locked = true;
      repeating = true;
    })
    (bindWithOpts "XF86MonBrightnessDown" ''hl.dsp.exec_cmd("dms ipc call brightness decrement 5")'' {
      locked = true;
      repeating = true;
    })
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
