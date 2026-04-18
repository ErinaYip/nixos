{
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "cli";
  name = "git";

  opts = {
    user = {
      name = lib.erinite.mkStrOpt "Demo User" "Git user name.";
      email = lib.erinite.mkStrOpt "demo@example.com" "Git user email.";
    };
  };

  configFn = { cfg, ... }: {
    environment.systemPackages = [pkgs.git];

    erinite.home = {
      programs.git = {
        enable = true;
        lfs.enable = true;
        userName = cfg.user.name;
        userEmail = cfg.user.email;
      };
    };
  };
}
