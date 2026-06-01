{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "presets";
    name = "common";

    configFn = _: {
      erinite.home = {
        browsers = {
          chromium = enabled;
          firefox = enabled;
        };

        desktop = {
          dms = enabled;
          hyprland = enabled;
          cursor = enabled;
          fcitx5 = enabled;
          fuzzel = enabled;
          # gtk = enabled;
          # matugen = enabled;
          nemo = enabled;
          # qq = enabled;
          # qt = enabled;
          stylix = enabled;
          # theme-specialisations = enabled;
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
