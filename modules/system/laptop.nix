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

    # services.auto-cpufreq.enable = true;
    # services.auto-cpufreq.settings = {
    #   battery = { governor = "powersave"; turbo = "auto"; };
    #   charger = { governor = "performance"; turbo = "auto"; };
    # };

    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "";
        CPU_ENERGY_PERF_POLICY_ON_AC = "";
        CPU_MIN_PERF_ON_AC = "";
        CPU_MAX_PERF_ON_AC = "";
        CPU_BOOST_ON_AC = "";

        # 电池模式下的 CPU 调度器和策略
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        # 限制 CPU 性能 (0-100%)。这里限制电池下最大仅发挥 30%-40% 性能，绝对够日常使用
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 40; 

        # 关闭睿频 (Turbo Boost) -> 降温省电的神器
        CPU_BOOST_ON_BAT = 0;

        # Intel 核显频率限制 (根据你的 CPU 调整，一般 300 是最低频率)
        INTEL_GPU_MIN_FREQ_ON_BAT = 300;
        INTEL_GPU_MAX_FREQ_ON_BAT = 450; # 限制核显最高频率

        # 网络和外设省电
        WIFI_PWR_ON_BAT = "on";
        PCIE_ASPM_ON_BAT = "powersupersave";

        # 声音声卡省电模式 (静音1秒后立刻休眠)
        SOUND_POWER_SAVE_ON_BAT = 1;

        # USB 自动休眠
        USB_AUTOSUSPEND = 1;
      };
    };
  };
}
