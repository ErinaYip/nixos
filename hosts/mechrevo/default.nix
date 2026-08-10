{eriniteLib, ...}: let
  inherit (eriniteLib) enabled;
in {
  imports = [./wallpapers.nix];

  osModules = [
    ./hardware-configuration.nix
    ./os.nix
    ./sunshine-host.nix
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

          mihomo = {
            enable = true;
            configFile = "/home/era/.config/mihomo/iKuuu_V2.yaml";
          };
        };

        desktop = {
          niri = enabled;
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
          kitty.sessions = {
            easytierfrp.settings = [
              {layout = "tall";}
              {cd = "~/Documents/natfrp-nix/";}
              {launch = ["nix-shell" "-p" "easytier" "--run" "zsh"];}
              {launch = ["nix" "run" ".#"];}
              {
                launch = [
                  "sudo nix run nixpkgs#easytier"
                  "--"
                  "-i 10.126.126.1"
                  "--network-name easytier"
                  "--network-secret easytier"
                ];
              }
            ];
          };
          git = {
            user = {
              name = "ErinaYip";
              email = "erinayip@outlook.com";
            };
          };
        };

        desktop = {
          niri = enabled;
          dms = {
            settings = {
              brightnessDevicePins = {
                "eDP-1" = "backlight:amdgpu_bl2";
                "eDP-2" = "backlight:amdgpu_bl2";
                "DP-2" = "ddc:i2c-9";
                "DP-3" = "ddc:i2c-9";
              };
            };
            bars = {
              mainBar.screenPreferences = ["all"];
              # mainBar.screenPreferences = ["DP-2" "DP-3"];
              # subBar.screenPreferences = ["eDP-1" "eDP-2"];
            };
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
