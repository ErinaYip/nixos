{eriniteLib, ...}: let
  inherit (eriniteLib) enabled;
in {
  imports = [./wallpapers.nix];

  osModules = [
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
          # network.proxyTun = true;
          laptop = enabled;
        };
      };
    }
  ];

  homeModules = [
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
