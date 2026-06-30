{eriniteLib, ...} @ args: let
  shared = import ../shared.nix args;
  theme = shared.mkTheme {
    "kurogame-neon-purple.png" = {
      url = "https://media-cdn-zspms.kurogame.com/pnswebsite/website2.0/images/1770134400000/f8pracrulrwq5570gx-177017628557319.png";
      hash = "sha256-5EGHH5D+VYMopFQTUy4TjPkLs3MN+e4VzBiJEXHiZUM=";
    };
    "kurogame-neon-green.png" = {
      url = "https://media-cdn-zspms.kurogame.com/pnswebsite/website2.0/images/1764000000000/4b9a8n00pfrq0tr3ex-176404372647915.png";
      hash = "sha256-EaqlkhrPWsYVsorKnRMT+zbAcKSuCi1NRvKtBfOIwis=";
    };
    "kurogame-silver-orange.png" = {
      url = "https://media-cdn-zspms.kurogame.com/pnswebsite/website2.0/images/1764000000000/vfr8pepbj8kv9i2ozf-17640438278579.png";
      hash = "sha256-9PnJsPlaKSd7MyhxaoMLsK0pwtnNph6R0SSKJtshrVY=";
    };
  };
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

  homeModules = with eriniteLib; [
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
