{
  default,
  hostName,
  eriniteLib,
  ...
} @ args: let
  inherit (builtins) elemAt listToAttrs;
in
  eriniteLib.mkModule args {
    configFn = _: {
      system.stateVersion = default.systemStateVersion;

      programs = {
        direnv.enable = true;
        appimage = {
          enable = true;
          binfmt = true;
        };
      };

      nixpkgs.config.allowUnfree = true;

      environment.shellAliases = listToAttrs (map (cmd: {
          name = "sn${elemAt cmd 0}";
          value = "sudo nixos-rebuild ${elemAt cmd 1} --flake .#${hostName}";
        }) [
          ["s" "switch"]
          ["b" "boot"]
          ["t" "test"]
          ["u" "build"]
        ]);

      nix.settings = {
        experimental-features = ["nix-command" "flakes" "configurable-impure-env"];

        auto-optimise-store = true;
        max-jobs = 16;
        impure-env = [
          "GOPROXY=https://goproxy.cn,direct"
        ];
        substituters = [
          "https://mirrors.ustc.edu.cn/nix-channels/store"
          "https://mirror.nju.edu.cn/nix-channels/store"
          "https://mirrors.cernet.edu.cn/nix-channels/store"
          "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
          "https://nix-community.cachix.org"
          "https://cache.nixos.org"
        ];

        trusted-users = [default.username "root" "@wheel"];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    };
  }
