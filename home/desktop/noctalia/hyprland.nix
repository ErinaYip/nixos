{lib, ...}: let
  raw = lib.generators.mkLuaInline;

  bindWithOpts = mods: command: opts: {
    _args = [
      mods
      (raw ''hl.dsp.exec_cmd("noctalia msg ${command}")'')
      opts
    ];
  };
  bind = mods: command: bindWithOpts mods command {};
in {
  wayland.windowManager.hyprland.settings = {
    window_rule = [
      {
        match.class = "^dev.noctalia.Noctalia$";
        float = true;
        size = [1080 920];
      }
    ];

    layer_rule = [
      {
        name = "noctalia";
        match.namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$";
        no_anim = true;
        ignore_alpha = 0.5;
        blur = true;
        blur_popups = true;
      }
    ];

    bind = [
      (bind "SUPER + space" "panel-toggle launcher")
      (bind "SUPER + V" "panel-toggle clipboard")
      (bind "SUPER + comma" "settings-toggle")
      (bind "SUPER + Y" "panel-toggle wallpaper")
      (bind "SUPER + O" "panel-toggle control-center")
      (bind "SUPER + TAB" "window-switcher")
      (bind "SUPER + ALT + L" "session lock")
      (bind "SUPER + X" "panel-toggle session")

      (bindWithOpts "XF86AudioRaiseVolume" "volume-up" {
        locked = true;
        repeating = true;
      })
      (bindWithOpts "XF86AudioLowerVolume" "volume-down" {
        locked = true;
        repeating = true;
      })
      (bindWithOpts "SUPER + XF86AudioRaiseVolume" "brightness-up" {
        locked = true;
        repeating = true;
      })
      (bindWithOpts "SUPER + XF86AudioLowerVolume" "brightness-down" {
        locked = true;
        repeating = true;
      })
      (bindWithOpts "XF86AudioMute" "volume-mute" {locked = true;})
      (bindWithOpts "XF86MonBrightnessUp" "brightness-up" {
        locked = true;
        repeating = true;
      })
      (bindWithOpts "XF86MonBrightnessDown" "brightness-down" {
        locked = true;
        repeating = true;
      })
    ];
  };
}
