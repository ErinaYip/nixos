let
  mkCenterWidgets = id: width: {
    inherit id width;
    enabled = true;
  };
in {
  currentThemeName = "dynamic";
  currentThemeCategory = "dynamic";
  widgetColorMode = "colorful";
  runDmsMatugenTemplates = false;

  acLockTimeout = 300;
  acMonitorTimeout = 360;
  acPostLockMonitorTimeout = 60;
  acProfileName = "1";
  acSuspendTimeout = 0;
  acSuspendBehavior = 0;

  batteryAutoPowerSaver = true;
  batteryLockTimeout = 180;
  batteryMonitorTimeout = 240;
  batteryPostLockMonitorTimeout = 30;
  batteryProfileName = "0";
  batterySuspendTimeout = 900;
  batterySuspendBehavior = 0;
  lowerDisplayRefreshRateOnBattery = true;
  lockBeforeSuspend = true;

  cornerRadius = 32;
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
  wallpaperFillMode = "Scrolling";

  wallpaperTransition = "random";
  includedTransitions = [
    "fade"
    "wipe"
    "disc"
    "stripes"
    "iris bloom"
    "pixelate"
    "portal"
  ];
}
