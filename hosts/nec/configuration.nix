# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

with lib.erinite; {
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
    "i915.enable_fbc=1"       # 开启帧缓冲压缩 (省显存带宽和电量)
    "i915.enable_psr=1"       # 开启面板自刷新 (画面静止时GPU休眠，极度省电)
    "i915.enable_guc=2"       # 开启 GuC/HuC 固件加载 (优化视频解码和电源管理)
    "pcie_aspm=force"         # 强制开启 PCIe 链路节能
    "intel_pstate=enable"
    "intel_idle.max_cstate=4"
    "drm.vblank_mode=1"
    "mitigations=off"
    "quiet" "splash"
    "nosmt"
  ];
  hardware.enableRedistributableFirmware = true;

  services.thermald.enable = true;
  powerManagement.powertop.enable = true;

  boot.blacklistedKernelModules = [
    "btusb" "bluetooth"
    "uvcvideo"
    "snd_hda_intel"
  ];
}

