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
          dms = enabled;
          hyprland = enabled;
          # niri = enabled;
          cursor = enabled;
          fcitx5 = enabled;
          fuzzel = enabled;
          # gtk = enabled;
          # matugen = enabled;
          qq = enabled;
          # qt = enabled;
          stylix = enabled;
          # theme-specialisations = enabled;
          vscode = enabled;
          wechat = enabled;
        };

        media = {
          nemo = enabled;
          xviewer = enabled;
          celluloid = enabled;
        };

        cli = {
          nvim = enabled;
          yazi = enabled;
          zsh = enabled;
          bat = enabled;
          btop = enabled;
          codex = enabled;
          eza = enabled;
          fastfetch = enabled;
          git = enabled;
          kitty = enabled;
          nh = enabled;
          opencode = enabled;
          starship = enabled;
          zoxide = enabled;
        };
      };
    };
  }
