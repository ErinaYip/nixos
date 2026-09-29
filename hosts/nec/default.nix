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
          laptop = enabled;

          mihomo = {
            enable = true;
            configFile = "/home/era/.config/mihomo/iKuuu_V2.yaml";
          };
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
          noctalia = {
            settings = {
              bar.main.position = "left";

              widget = {
                ram.show_value = false;
                cpu.show_value = false;
                network_tx.show_value = false;
                network_rx.show_value = false;
              };
            };
          };
        };
      };
    }
  ];
}
