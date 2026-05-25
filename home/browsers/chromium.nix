{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  namespace = ["erinite" "home"];
  category = "browsers";
  name = "chromium";

  configFn = _: {
    programs.chromium = {
      enable = true;

      extensions = [
        {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
        {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # Dark Reader
        {id = "ginpbkfigcoaokgflihfhhmglmbchinc";} # HackBar
        {id = "gppongmhjkpfnbhagpmjfkannfbllamg";} # Wappalyzer
        {id = "pfnededegaaopdmhkdmcofjmoldfiped";} # Proxy SwitchyOmega 3 / ZeroOmega
      ];
    };

    xdg.configFile."chromium/Default/Bookmarks" = {
      source = ../../assets/browser-profiles/chromium/Bookmarks;
      force = true;
    };
  };
}
