{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    category = "presets";
    name = "common";

    configFn = _: {
      erinite = {
        system = {
          boot = enabled;
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
          hyprland = enabled;
          # obs-studio = enabled;
          # streaming = enabled;
          # stylix = enabled;
          # theme-specialisations = enabled;
        };

        programs = {
          # gaming = enabled;
          localsend = enabled;
        };
      };
    };
  }
