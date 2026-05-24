{
  pkgs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  namespace = ["erinite" "home"];
  category = "browsers";
  name = "chromium";

  configFn = _: {
    programs.chromium = {
      enable = true;
      package = pkgs.chromium;

      extensions = [
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
        "ginpbkfigcoaokgflihfhhmglmbchinc" # HackBar
        "gppongmhjkpfnbhagpmjfkannfbllamg" # Wappalyzer
        "pfnededegaaopdmhkdmcofjmoldfiped" # Proxy SwitchyOmega 3 / ZeroOmega
      ];
    };

    xdg.configFile."chromium/Default/Bookmarks" = {
      source = ../../assets/browser-profiles/chromium/Bookmarks;
      force = true;
    };
  };
}
