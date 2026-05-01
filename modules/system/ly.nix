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
        animate = true;
        animation = "0";      # 0=PSX, 1=Doom, 2=Matrix (根据你的需求调整)
        hide_borders = false;
      };
    };

    environment.etc."ly/custom.dur".source = ../../assets/blackhole-smooth-240x67.dur; 
  };
}
