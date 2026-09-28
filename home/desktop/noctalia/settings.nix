{wallpaper}: {
  shell = {
    app_icon_color = "primary";
    corner_radius_scale = 2.0;
    panel.transparency_mode = "soft";
  };

  theme = {
    builtin = "Noctalia";
    community_palette = "Oxocarbon";
    mode = wallpaper.polarity;
    source = "wallpaper";
    wallpaper_scheme = "m3-tonal-spot";
  };

  wallpaper = {
    enabled = true;
    # default.path = wallpaper.path;
    directory = dirOf wallpaper.path;
  };

  weather.enabled = false;
  brightness.enable_ddcutil = true;
}
