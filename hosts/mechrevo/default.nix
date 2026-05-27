{
  lib,
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args: let
  goodKernelPkgs = import inputs.nixpkgs-kernel-good {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
  shared = import ../shared.nix args;
  inherit (shared) theme;
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
        };
      };
    }
    ./home.nix
  ];
}
