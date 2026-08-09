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
