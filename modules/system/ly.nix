{
  eriniteLib,
  ...
} @ args:

eriniteLib.mkModule args {
  category = "system";
  name = "ly";

  configFn = { ... }: {
    services.displayManager.ly = {
      enable = true;

      settings = {
        hide_borders = false;
        full_color = true;
        bigclock = "en";
        bigclock_seconds = true;
        animation = "dur_file";
        dur_file_path = "/etc/ly/blackhole.dur";
      };
    };

    environment.etc."ly/blackhole.dur".source = ../../assets/blackhole-smooth-240x67.dur; 
  };
}
