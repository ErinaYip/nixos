{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    services = {
      upower.enable = true;
      tuned.enable = true;
    };

    # services.tlp = {
    #   enable = true;
    #   settings = {
    #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
    #     CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    #     CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    #
    #     CPU_MIN_PERF_ON_AC = 0;
    #     CPU_MAX_PERF_ON_AC = 100;
    #     CPU_MIN_PERF_ON_BAT = 0;
    #     CPU_MAX_PERF_ON_BAT = 20;
    #
    #     CPU_BOOST_ON_BAT = 0;
    #
    #     WIFI_PWR_ON_BAT = "on";
    #     PCIE_ASPM_ON_BAT = "powersupersave";
    #
    #     SOUND_POWER_SAVE_ON_BAT = 1;
    #
    #     USB_AUTOSUSPEND = 1;
    #
    #     START_CHARGE_THRESH_BAT0 = 40;
    #     STOP_CHARGE_THRESH_BAT0 = 80;
    #   };
    # };
  };
}
