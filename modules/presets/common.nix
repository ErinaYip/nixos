{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    category = "presets";
    name = "common";

    configFn = _: {
      erinite = {
        system = {
          boot = enabled;
          fcitx5 = enabled;
          fonts = enabled;
          i18n = enabled;
          kernel = enabled;
          keyd = enabled;
          # laptop = enabled;
          ly = enabled;
          media = enabled;
          network = enabled;
          nh = enabled;
          nix-ld = enabled;
          nix = enabled;
          # nvidia = enabled;
          # sddm = enabled;
          sound = enabled;
          users = enabled;
          # virtualisation = enabled;
        };

        desktop = {
          dms = enabled;
          hyprland = enabled;
          cursor = enabled;
          fuzzel = enabled;
          gtk = enabled;
          matugen = enabled;
          nemo = enabled;
          qt = enabled;
          # streaming = enabled;
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
          nix = enabled;
          nvim = enabled;
          starship = enabled;
          zoxide = enabled;
        };

        programs = {
          # gaming = enabled;
          localsend = enabled;
        };
      };
    };
  }
