# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, eriniteLib, ... }:

with eriniteLib; {
  boot.loader = {
    grub = {
      extraEntries = ''
        menuentry "Windows" {
          search --file --no-floppy --set=root /EFI/Microsoft/Boot/bootmgfw.efi
          chainloader (''${root})/EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
    };
    efi.efiSysMountPoint = "/boot";
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    vscode

    zip
    unzip
    gcc
    gdb
    python3
    uv
    pnpm
    nodejs

    qq
  ];

  boot.kernelParams = [
    "pcie_aspm=force"
    "intel_pstate=enable"
    "intel_idle.max_cstate=4"
    "drm.vblank_mode=1"
    "mitigations=off"
    "quiet" "splash"
    "nosmt"
  ];

  services.thermald.enable = true;

  boot.blacklistedKernelModules = [
    "btusb" "bluetooth"
    "uvcvideo"
    "snd_hda_intel"
  ];
}

