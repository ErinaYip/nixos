{
  inputs,
  pkgs,
  lib,
  eriniteLib,
  ...
}: let
  goodKernelPkgs = import inputs.nixpkgs-kernel-good {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in {
  meta = {
    cudaSupport = true;
  };

  module = with eriniteLib; {
    imports = [
      ./hardware-configuration.nix
      ./configuration.nix
    ];

    boot.kernelPackages = lib.mkForce goodKernelPkgs.linuxPackages_latest;

    erinite = {
      presets = {
        common = enabled;
      };

      system = {
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
        theme-specialisations = {
          enable = true;
          default = "kurogame-olive";
          wallpapers = {
            kurogame-olive = {
              image = pkgs.fetchurl {
                name = "kurogame-olive.png";
                url = "https://media-cdn-zspms.kurogame.com/pnswebsite/website2.0/images/1773936000000/6y9pm8iicrjyhd354y-17739965643372.png";
                hash = "sha256-wdC7ZU7KChFkyQW0B5twnpq4i1nFIovfyNEklSY973I=";
              };
            };
            kurogame-blue = {
              image = pkgs.fetchurl {
                name = "kurogame-blue.png";
                url = "https://media-cdn-zspms.kurogame.com/pnswebsite/website2.0/images/1773936000000/ogvbi74cjtbp460lif-17739965468193.png";
                hash = "sha256-Hl/vRLR2V0F3JRrYl0JYjxWN9KVWkFpzaWFojOXHmJQ=";
              };
            };
          };
        };
      };

      cli = {
        codex = enabled;
        opencode = enabled;
        git = {
          user = {
            name = "ErinaYip";
            email = "erinayip@outlook.com";
          };
        };
      };

      programs = {
        gaming = enabled;
      };
    };
  };
}
