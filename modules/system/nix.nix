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

    nix.settings.experimental-features = [ "nix-command" "flakes" "configurable-impure-env" ];

    nixpkgs.config.allowUnfree = true;

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    nix.settings.auto-optimise-store = true;
    nix.settings.max-jobs = 16;
    nix.settings.impure-env = [
      "GOPROXY=https://goproxy.cn,direct"
    ];
    nix.settings.substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirror.nju.edu.cn/nix-channels/store"
      "https://mirrors.cernet.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];

    programs.direnv.enable = true;
  };
}
