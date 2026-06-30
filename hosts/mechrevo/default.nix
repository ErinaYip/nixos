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
          adb = enabled;
          boot.engine = "grub";
          kernel.sched_ext = true;
          network.proxy = true;
          laptop = enabled;
          virtualisation = {
            enable = true;
            podman = true;
            vbox = true;
            wine = true;
          };

          nvidia = {
            enable = true;
            prime = {
              enable = true;
              nvidiaBusId = "PCI:1:0:0";
              amdgpuBusId = "PCI:6:0:0";
            };
          };
        };

        desktop = {
          obs-studio = enabled;
        };

        programs.gaming = enabled;
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

        games = {
          prismlauncher = enabled;
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
          dms.bars = {
            mainBar.screenPreferences = ["DP-2" "DP-3"];
            subBar.screenPreferences = ["eDP-1" "eDP-2"];
          };
          obsidian = {
            enable = true;
            vaults.notes.target = "Documents/notes";
          };
        };
      };
    }
  ];
}
