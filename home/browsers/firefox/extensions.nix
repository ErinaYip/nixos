let
  moz = name: "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi";

  mkExtension = name: {
    install_url = moz name;
    installation_mode = "force_installed";
    updates_disabled = true;
  };
in {
  ExtensionSettings = {
    "*".installation_mode = "blocked";

    "suziwen1@gmail.com" = mkExtension "zeroomega";
    "addon@celeus.cn" = mkExtension "bewlycat";
    "uBlock0@raymondhill.net" = mkExtension "ublock-origin";
    "authenticator@mymindstorm" = mkExtension "authenticator";
    "{8e515334-52b5-4cc5-b4e8-675d50af677d}" = mkExtension "scriptcat";
    "addon@darkreader.org" = mkExtension "darkreader";
  };

  "3rdparty".Extensions = {
    "addon@darkreader.org".settings = {
      enabled = true;
      enabledByDefault = true;

      detectDarkTheme = true;
      enableContextMenus = false;
      enableForPDF = true;
      enableForProtectedPages = true;
    };
  };
}
