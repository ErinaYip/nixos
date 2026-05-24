{
  pkgs,
  eriniteLib,
  ...
}: let
  theme = {
    default = "kurogame-blue";
    wallpapers = {
      kurogame-blue = {
        polarity = "dark";
        image = pkgs.fetchurl {
          name = "kurogame-blue.png";
          url = "https://media-cdn-zspms.kurogame.com/pnswebsite/website2.0/images/1773936000000/ogvbi74cjtbp460lif-17739965468193.png";
          hash = "sha256-Hl/vRLR2V0F3JRrYl0JYjxWN9KVWkFpzaWFojOXHmJQ=";
        };
      };
    };
  };
in {
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

        desktop = {
          theme-specialisations = disabled;
          stylix.settings = theme.wallpapers.${theme.default};
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

        desktop = {
          theme-specialisations = disabled;
          stylix.settings = theme.wallpapers.${theme.default};
        };
      };
    }
    ./home.nix
  ];
}
