{eriniteLib, ...}: {
  meta = {};

  osModules = with eriniteLib; [
    ./hardware-configuration.nix
    ./os.nix
    {
      erinite = {
        presets.common = enabled;

        system = {
          boot.engine = "grub";
          network.proxy = true;
          laptop = enabled;
        };
      };
    }
  ];

  homeModules = with eriniteLib; [
    {
      erinite.home = {
        presets.common = enabled;
        cli = {
          git = {
            user = {
              name = "ErinaYip";
              email = "erinayip@outlook.com";
            };
          };
        };
      };
    }
    ./home.nix
  ];
}
