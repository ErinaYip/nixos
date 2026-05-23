{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  namespace = ["erinite" "home"];
  category = "cli";
  name = "zoxide";

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
