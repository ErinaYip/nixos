{ config, pkgs, ... }: {
  imports = [
    ./nvidia.nix
    ./boot.nix
    ./hardware-configuration.nix
  ];

  users.users.era = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "adbusers" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://mirror.sjtu.edu.cn/nix-channels/store"
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    # "https://cache.nixos-cuda.org"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.settings.auto-optimise-store = true;
  nix.settings.max-jobs = 16;

  networking.hostName = "nixos";
  system.stateVersion = "25.11";
}
