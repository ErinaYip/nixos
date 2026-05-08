{
  general = {
    gaps_in = 4;
    gaps_out = 4;
    border_size = 2;
    layout = "master";
    resize_on_border = true;
  };

  misc = {
    disable_hyprland_logo = true;
    disable_splash_rendering = true;
  };

  master = {
    new_status = "master";
    new_on_top = true;
  };

  scrolling = {
    column_width = 0.5;
    explicit_column_widths = "0.333, 0.5, 0.667, 0.833";
    follow_min_visible = 0;
  };

  xwayland = {
    enabled = true;
    force_zero_scaling = true;
  };

  env = [
    "QT_IM_MODULE,fcitx"
    "XMODIFIERS,@im=fcitx"
    "QT_IM_MODULES,wayland;fcitx"
    "SDL_IM_MODULE,fcitx"
    "GLFW_IM_MODULE,ibus"

    "GDK_BACKEND,wayland,x11"
    "QT_QPA_PLATFORM,wayland;xcb"
    "SDL_VIDEODRIVER,wayland"
    "CLUTTER_BACKEND,wayland"
    "MOZ_ENABLE_WAYLAND,1"
    "XCURSOR_SIZE,24"
    "XCURSOR_THEME,Bibata-Modern-Ice"
  ];

  input = {
    follow_mouse = true;
    accel_profile = "flat";

    repeat_delay = 300;
    repeat_rate = 40;

    touchpad = {
      natural_scroll = true;
    };
  };

  decoration = {
    rounding = 12;
    active_opacity = 0.9;
    inactive_opacity = 0.8;

    shadow = {
      enabled = true;
      range = 4;
      render_power = 3;
      color = "rgba(1a1a1aee)";
    };

    blur = {
      enabled = true;
      size = 3;
      passes = 2;
      vibrancy = 0.1696;
    };
  };

  animations = {
    enabled = true;

    bezier = [
      "quickInOut, 0.4, 0.0, 0.2, 1.0"
    ];

    animation = [
      "workspaces, 1, 3, quickInOut, slidevert"
      "global, 1, 3, quickInOut"
      "windows, 1, 3, quickInOut, slide"
      "fade, 1, 3, quickInOut"
    ];
  };
}
