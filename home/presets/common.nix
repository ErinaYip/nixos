{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    configFn = _: {
      erinite.home = {
        browsers = {
          chromium = enabled;
          firefox = enabled;
        };

        desktop = {
          hyprland = enabled;
          noctalia = enabled;
          cursor = enabled;
          fcitx5 = enabled;
          fuzzel = enabled;
          # gtk = enabled;
          # matugen = enabled;
          qq = enabled;
          # qt = enabled;
          stylix = enabled;
          vscode = enabled;
          wechat = enabled;
        };

        media = {
          nemo = enabled;
          xviewer = enabled;
          celluloid = enabled;
          wemeet = enabled;
        };

        cli = {
          nvim = enabled;
          yazi = enabled;
          zsh = enabled;
          bat = enabled;
          btop = enabled;
          eza = enabled;
          fastfetch = enabled;
          git = enabled;
          herdr = enabled;
          kitty = enabled;
          nh = enabled;
          opencode = enabled;
          pi = enabled;
          starship = enabled;
          zoxide = enabled;
        };
      };
    };
  }
