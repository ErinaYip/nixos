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
        dur_file_path = "/etc/ly/blackhole.dur";
      };
    };

    environment.etc."ly/blackhole.dur".source = ../../assets/blackhole-smooth-240x67.dur;
  };
}
