{
  lib,
  default,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "system";
  name = "nix";

  configFn = { ... }: {
    system.stateVersion = default.systemStateVersion;

    programs.appimage.enable = true;
    programs.appimage.binfmt = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nixpkgs.config.allowUnfree = true;

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    nix.settings.auto-optimise-store = true;
    nix.settings.max-jobs = 16;

    nix.settings.substituters = [
      "https://mirrors.cernet.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
      "https://noctalia.cachix.org"
      "https://hyprland.cachix.org"
    ];
    nix.settings.trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
