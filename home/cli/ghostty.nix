{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    configFn = _: {
      programs.ghostty = {
        enable = true;
        enableZshIntegration = true;
        installBatSyntax = true;

        settings = {
          command = "zsh";
          font-family = "MapleMono NF CN";
          cursor-style = "bar";

          window-decoration = "none";
          window-padding-x = 0;
          window-padding-y = 0;

          confirm-close-surface = false;
          mouse-hide-while-typing = true;
          mouse-scroll-multiplier = 0.1;

          keybind = [
            "ctrl+backspace=reset_font_size"
            "ctrl+plus=increase_font_size:1"
            "ctrl+equal=increase_font_size:1"
          ];
        };
      };
    };
  }
