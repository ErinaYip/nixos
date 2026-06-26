{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    programs.zoxide = {
      enable = true;
      options = [
        "--cmd z"
      ];
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
  };
}
