{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    programs.herdr = {
      enable = true;
      settings = {
        terminal = {
          default_shell = "zsh";
        };

        ui = {
          # toast.delivery = "system";
        };
      };
    };
  };
}
