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
in
  with eriniteLib; {
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

      browsers = {
        firefox = enabled;
        chromium = enabled;
      };

      programs = {
        gaming = enabled;
      };
    };
  }
