{eriniteLib, ...} @ args: let
  shared = import ../shared.nix args;
  inherit (shared) theme;
in {
  osModules = with eriniteLib; [
    ./hardware-configuration.nix
    ./os.nix
    {
      erinite = {
        presets = {
          common = enabled;
          stylix = enabled;
        };

        system = {
          boot.engine = "grub";
          network.proxy = true;
          laptop = enabled;
        };

        desktop = {
          theme-specialisations = theme;
        };
      };
    }
  ];

  homeModules = with eriniteLib; [
    {
      erinite.home = {
        presets = {
          common = enabled;
          stylix = enabled;
        };

        cli = {
          git = {
            user = {
              name = "ErinaYip";
              email = "erinayip@outlook.com";
            };
          };
        };

        desktop = {
          theme-specialisations = theme;
        };
      };
    }
    ./home.nix
  ];
}
