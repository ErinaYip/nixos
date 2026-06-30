{eriniteLib, ...} @ args: let
  shared = import ../shared.nix args;
  inherit (shared) theme;
in {
  wallpapers = theme;

  osModules = with eriniteLib; [
    ./hardware-configuration.nix
    ./os.nix
    {
      erinite.os = {
        presets = {
          common = enabled;
          stylix = enabled;
        };

        system = {
          boot.engine = "grub";
          # network.proxy = true;
          laptop = enabled;
        };
      };
    }
  ];

  homeModules = with eriniteLib; [
    ./home.nix
    {
      erinite.home = {
        presets = {
          common = enabled;
          stylix = enabled;
        };

        cli = {
          ghostty = enabled;
          git = {
            user = {
              name = "ErinaYip";
              email = "erinayip@outlook.com";
            };
          };
        };

        desktop = {
          theme-specialisations = enabled;
        };
      };
    }
  ];
}
