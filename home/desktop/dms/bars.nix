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
in {
  mainBar = {
    id = "mainBar";
    name = "Main Bar";
    enabled = true;
    position = 0;
    screenPreferences = ["all"];
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
    fontScale = 1.2;
    iconScale = 1.2;
    shadowOpacity = 100;
    shadowColorMode = "custom";
  };

  subBar = {
    id = "subBar";
    name = "Sub Bar";
    enabled = true;
    position = 0;
    screenPreferences = [];
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
      (mkWidgets "controlCenterButton" [])
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
  };
}
