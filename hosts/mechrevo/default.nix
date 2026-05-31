{
  lib,
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args: let
  inherit (eriniteLib.themeSpecialisations) mkWallpapers;
  goodKernelPkgs = import inputs.nixpkgs-kernel-good {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
  shared = (import ../shared.nix args).theme;
  theme = {
    inherit (shared) default;
    wallpapers =
      shared.wallpapers
      // mkWallpapers {
        "kurogame-neon-purple.png" = {
          url = "https://media-cdn-zspms.kurogame.com/pnswebsite/website2.0/images/1770134400000/f8pracrulrwq5570gx-177017628557319.png";
          hash = "sha256-5EGHH5D+VYMopFQTUy4TjPkLs3MN+e4VzBiJEXHiZUM=";
        };
        "kurogame-silver-orange.png" = {
          url = "https://media-cdn-zspms.kurogame.com/pnswebsite/website2.0/images/1764000000000/vfr8pepbj8kv9i2ozf-17640438278579.png";
          hash = "sha256-9PnJsPlaKSd7MyhxaoMLsK0pwtnNph6R0SSKJtshrVY=";
        };
      };
  };
in {
  osModules = with eriniteLib; [
    ./hardware-configuration.nix
    ./os.nix
    {
      boot.kernelPackages = lib.mkForce goodKernelPkgs.linuxPackages_latest;

      erinite = {
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
          theme-specialisations = theme;
        };

        programs.gaming = enabled;
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
          wechat = enabled;
        };
      };
    }
    ./home.nix
  ];
}
