{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    services.displayManager.ly = {
      enable = true;

      settings = {
        hide_borders = false;
        full_color = true;
        bigclock = "en";
        bigclock_seconds = true;
        clear_password = true;
        animation = "dur_file";
        ly_log = "/var/log/ly.log";
        session_log = ".local/state/ly-session.log";
        dur_file_path = "${../../assets/blackhole-smooth-240x67.dur}";
      };
    };
  };
}
