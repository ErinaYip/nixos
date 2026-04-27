{
  lib,
  eriniteLib,
  ...
} @ args:

eriniteLib.mkModule args {
  category = "system";
  name = "laptop";

  configFn = { ... }: {
    services.upower.enable = true;
    services.tuned.enable = false;
    services.power-profiles-daemon.enable = false;

    services.auto-cpufreq.enable = true;
    services.auto-cpufreq.settings = {
      battery = { governor = "powersave"; turbo = "auto"; };
      charger = { governor = "performance"; turbo = "auto"; };
    };

    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "";
        CPU_SCALING_GOVERNOR_ON_BAT = "";
        CPU_ENERGY_PERF_POLICY_ON_AC = "";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "";
        CPU_MIN_PERF_ON_AC = "";
        CPU_MAX_PERF_ON_AC = "";
        CPU_MIN_PERF_ON_BAT = "";
        CPU_MAX_PERF_ON_BAT = "";
        CPU_BOOST_ON_AC = "";
        CPU_BOOST_ON_BAT = "";

        SOUND_POWER_SAVE_ON_BAT = 1;

        USB_AUTOSUSPEND = 1; 
      };
    };
  };
}
