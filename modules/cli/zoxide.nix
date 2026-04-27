{
  lib,
  eriniteLib,
  ...
} @ args:

eriniteLib.mkModule args {
  category = "cli";
  name = "zoxide";

  configFn = { ... }: {
    erinite.home.programs.zoxide = {
      enable = true;
      options = [
        "--cmd z"
      ];
      enableBashIntegration= true;
      enableFishIntegration= true;
      enableZshIntegration = true;
    };
  };
}
