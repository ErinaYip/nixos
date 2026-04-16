{
  lib,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "cli";
  name = "zoxide";

  configFn = { ... }: {
    erinite.home.config.programs.zoxide = {
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
