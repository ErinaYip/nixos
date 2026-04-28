{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:

eriniteLib.mkModule args {
  category = "cli";
  name = "git";

  opts = {
    user = {
      name = eriniteLib.mkStrOpt "Demo User" "Git user name.";
      email = eriniteLib.mkStrOpt "demo@example.com" "Git user email.";
    };
  };

  configFn = { cfg, ... }: {
    environment.systemPackages = [pkgs.git];

    erinite.home = {
      programs.git = {
        enable = true;
        lfs.enable = true;
        settings = {
          user.name = cfg.user.name;
          user.email = cfg.user.email;
          init.defaultBranch = "main";
        };

      };
    };
  };
}
