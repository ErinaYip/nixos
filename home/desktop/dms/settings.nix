let
  mkWidgets = id: disabledOptions:
    {
      inherit id;
      enabled = true;
    }
    // builtins.listToAttrs (
      map (name: {
        inherit name;
        value = false;
      })
      disabledOptions
    );
  mkCenterWidgets = id: width: {
    inherit id width;
    enabled = true;
  };
in {
  currentThemeName = "dynamic";
  # monoFontFamily = "Maple Mono NF CN ExtraBold";

  currentThemeCategory = "dynamic";
  widgetColorMode = "colorful";
  cornerRadius = 32;
  # controlCenterShowMicPercent = false;
  controlCenterWidgets = [
    (mkCenterWidgets "volumeSlider" 50)
    (mkCenterWidgets "brightnessSlider" 50)
    (mkCenterWidgets "wifi" 50)
    (mkCenterWidgets "bluetooth" 50)
    (mkCenterWidgets "audioOutput" 50)
    (mkCenterWidgets "audioInput" 50)
    (mkCenterWidgets "nightMode" 25)
    (mkCenterWidgets "idleInhibitor" 25)
    (mkCenterWidgets "darkMode" 50)
    (mkCenterWidgets "doNotDisturb" 50)
    (mkCenterWidgets "colorPicker" 50)
  ];
  showWorkspaceIndex = true;

  # weatherEnabled = false;
  # networkPreference = "wifi";
  # fontWeight = 600;
  # fadeToLockEnabled = false;
  # osdPowerProfileEnabled = false;

  barConfigs = [
    {
      id = "mainBar";
      name = "Main Bar";
      enabled = true;
      position = 0;
      screenPreferences = ["DP-2" "DP-3"];
      # showOnLastDisplay = false;
      leftWidgets = [
        (mkWidgets "launcherButton" [])
        (mkWidgets "cpuUsage" ["minimumWidth"])
        (mkWidgets "memUsage" [
          "minimumWidth"
          "showSwap"
        ])
        (mkWidgets "network_speed_monitor" [])
        (mkWidgets "focusedWindow" [])
        (mkWidgets "layout" [])
      ];
      centerWidgets = [
        (mkWidgets "workspaceSwitcher" [])
        (mkWidgets "runningApps" [
          "runningAppsGroupByApp"
          "runningAppsCurrentWorkspace"
          "runningAppsCurrentMonitor"
        ])
        (mkWidgets "clock" ["clockCompactMode"])
      ];
      rightWidgets = [
        (mkWidgets "music" [])
        (mkWidgets "systemTray" [])
        (mkWidgets "clipboard" [])
        (mkWidgets "notificationButton" [])
        (mkWidgets "battery" [])
        (mkWidgets "controlCenterButton" [])
      ];
      spacing = 0;
      innerPadding = -2;
      transparency = 0.8;
      squareCorners = true;
      gothCornersEnabled = true;
      gothCornerRadiusOverride = true;
      gothCornerRadiusValue = 16;
      widgetOutlineEnabled = true;
      widgetOutlineOpacity = 0.19;
      widgetOutlineThickness = 2;
      # fontScale = 1.2;
      # iconScale = 1.2;
      # shadowOpacity = 100;
      # shadowColorMode = "custom";
    }
    {
      id = "subBar";
      name = "Sub Bar";
      enabled = true;
      position = 0;
      screenPreferences = ["eDP-2" "eDP-1"];
      showOnLastDisplay = false;
      leftWidgets = [
        (mkWidgets "workspaceSwitcher" [])
      ];
      centerWidgets = [
        (mkWidgets "clock" [])
        (mkWidgets "music" [])
        (mkWidgets "focusedWindow" [])
      ];
      rightWidgets = [
        (mkWidgets "clipboard" [])
        (mkWidgets "notificationButton" [])
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
}
