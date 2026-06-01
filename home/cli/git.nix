{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  namespace = ["erinite" "home"];
  category = "cli";
  name = "git";

  opts = {
    user = {
      name = eriniteLib.mkStrOpt "Demo User" "Git user name.";
      email = eriniteLib.mkStrOpt "demo@example.com" "Git user email.";
    };
  };

  configFn = {cfg, ...}: {
    programs.git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user.name = cfg.user.name;
        user.email = cfg.user.email;
        init.defaultBranch = "main";
        gpg.format = "ssh";
        pull.rebaes = false;
        alias = {
          s = "status";
          c = "checkout";
          f = "fetch";
          k = "push";
          ps = "push";
          j = "pull";
          pl = "pull";
        };
      };
      signing = {
        key = "~/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
    };
  };
}
