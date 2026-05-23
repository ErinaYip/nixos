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
          nemo = enabled;
          stylix = enabled;
        };

        cli = {
          yazi = enabled;
          zsh = enabled;
          bat = enabled;
          btop = enabled;
          eza = enabled;
          fastfetch = enabled;
          git = enabled;
          kitty = enabled;
          nh = enabled;
          nix = enabled;
          nvim = enabled;
          starship = enabled;
          zoxide = enabled;
        };
      };
    };
  }
