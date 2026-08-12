{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    programs.herdr = {
      enable = true;
      settings = {
        terminal = {
          default_shell = "zsh";
        };

        keys = {
          prefix = "alt+space";
          switch_tab = "alt+1..9";
          switch_workspace = "ctrl+1..9";
          focus_agent = "alt+shift+1..9";
        };

        ui = {
          # toast.delivery = "system";
        };
      };
    };
  };
}
