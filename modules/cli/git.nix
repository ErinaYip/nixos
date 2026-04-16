{
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "cli";
  name = "git";

  defaultSettings = {
    init.defaultBranch = "main";
  };

  opts = {
    user = {
      name = lib.erinite.mkStrOpt "Demo User" "Git user name.";
      email = lib.erinite.mkStrOpt "demo@example.com" "Git user email.";
    };
  };

  configFn = { cfg, settings, ... }: {
    environment.systemPackages = [pkgs.git];

    erinite.home = {
      programs.git = {
        enable = true;
        lfs.enable = true;
        settings = settings // {
          user.name = cfg.user.name;
          user.email = cfg.user.email;
        };
      };
    };
  };
}
