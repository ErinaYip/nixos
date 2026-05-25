{
  currentThemeName = "dynamic";
  currentThemeCategory = "dynamic";
  widgetColorMode = "colorful";
  cornerRadius = 32;
  controlCenterShowMicPercent = false;
  controlCenterWidgets = [
    {
      id = "volumeSlider";
      enabled = true;
      width = 50;
    }
    {
      id = "brightnessSlider";
      enabled = true;
      width = 50;
      deviceName = "backlight:amdgpu_bl2";
    }
    {
      id = "wifi";
      enabled = true;
      width = 50;
    }
    {
      id = "bluetooth";
      enabled = true;
      width = 50;
    }
    {
      id = "audioOutput";
      enabled = true;
      width = 50;
    }
    {
      id = "audioInput";
      enabled = true;
      width = 50;
    }
    {
      id = "nightMode";
      enabled = true;
      width = 50;
    }
    {
      id = "darkMode";
      enabled = true;
      width = 50;
    }
    {
      id = "idleInhibitor";
      enabled = true;
      width = 50;
    }
    {
      id = "doNotDisturb";
      enabled = true;
      width = 50;
    }
    {
      id = "colorPicker";
      enabled = true;
      width = 50;
    }
  ];
  showWorkspaceIndex = true;

  appIdSubstitutions = [
    {
      pattern = "Spotify";
      replacement = "spotify";
      type = "exact";
    }
    {
      pattern = "beepertexts";
      replacement = "beeper";
      type = "exact";
    }
    {
      pattern = "home assistant desktop";
      replacement = "homeassistant-desktop";
      type = "exact";
    }
    {
      pattern = "com.transmissionbt.transmission";
      replacement = "transmission-gtk";
      type = "contains";
    }
    {
      pattern = "^steam_app_(\\d+)$";
      replacement = "steam_icon_$1";
      type = "regex";
    }
  ];

  weatherEnabled = false;
  networkPreference = "wifi";

  monoFontFamily = "Maple Mono NF CN ExtraBold";
  fontWeight = 600;

  fadeToLockEnabled = false;

  osdPowerProfileEnabled = false;

  barConfigs = [
    {
      id = "default";
      name = "Main Bar";
      enabled = true;
      position = 0;
      screenPreferences = [
        "all"
      ];
      showOnLastDisplay = false;
      leftWidgets = [
        {
          id = "launcherButton";
          enabled = true;
        }
        {
          id = "cpuUsage";
          enabled = true;
          minimumWidth = false;
        }
        {
          id = "memUsage";
          enabled = true;
          minimumWidth = false;
          showSwap = false;
        }
        {
          id = "network_speed_monitor";
          enabled = true;
        }
        {
          id = "focusedWindow";
          enabled = true;
        }
        {
          id = "layout";
          enabled = true;
        }
      ];
      centerWidgets = [
        {
          id = "workspaceSwitcher";
          enabled = true;
        }
        {
          id = "runningApps";
          enabled = true;
          runningAppsGroupByApp = false;
          runningAppsCurrentWorkspace = false;
          runningAppsCurrentMonitor = false;
        }
        {
          id = "clock";
          enabled = true;
          clockCompactMode = false;
        }
      ];
      rightWidgets = [
        {
          id = "music";
          enabled = true;
        }
        {
          id = "systemTray";
          enabled = true;
        }
        {
          id = "clipboard";
          enabled = true;
        }
        {
          id = "notificationButton";
          enabled = true;
        }
        {
          id = "battery";
          enabled = true;
        }
        {
          id = "controlCenterButton";
          enabled = true;
        }
      ];
      spacing = 0;
      innerPadding = 0;
      transparency = 0.8;
      squareCorners = true;
      gothCornersEnabled = true;
      gothCornerRadiusOverride = true;
      gothCornerRadiusValue = 16;
      widgetOutlineEnabled = true;
      widgetOutlineOpacity = 0.19;
      widgetOutlineThickness = 2;
      fontScale = 1.2;
      iconScale = 1.2;
      shadowOpacity = 100;
      shadowColorMode = "custom";
    }
    {
      id = "bar1776936686449";
      name = "Bar 2";
      enabled = true;
      position = 0;
      screenPreferences = [
      ];
      showOnLastDisplay = false;
      leftWidgets = [
        {
          id = "clock";
          enabled = true;
          clockCompactMode = false;
        }
      ];
      centerWidgets = [
        {
          id = "music";
          enabled = true;
        }
        {
          id = "focusedWindow";
          enabled = true;
          focusedWindowCompactMode = false;
        }
        {
          id = "workspaceSwitcher";
          enabled = true;
        }
      ];
      rightWidgets = [
        {
          id = "clipboard";
          enabled = true;
        }
        {
          id = "notificationButton";
          enabled = true;
        }
      ];
      spacing = 0;
      innerPadding = 0;
      transparency = 0.8;
      squareCorners = true;
      gothCornersEnabled = true;
      gothCornerRadiusOverride = true;
      gothCornerRadiusValue = 16;
      widgetOutlineEnabled = true;
      widgetOutlineOpacity = 0.19;
      widgetOutlineThickness = 2;
      fontScale = 1.2;
      iconScale = 1.2;
      shadowOpacity = 100;
      shadowColorMode = "custom";
    }
  ];
  launcherPluginVisibility = {
    "dms_settings_search" = {
      allowWithoutTrigger = true;
    };
  };
}
