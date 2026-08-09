{
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    configFn = _: {
      nixpkgs.overlays = [inputs.niri.overlays.niri];
      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };

      environment = {
        systemPackages = with pkgs; [
          wl-clipboard
        ];

        localBinInPath = true;
        pathsToLink = [
          "/share/applications"
          "/share/xdg-desktop-portal"
        ];
      };

      nix.settings = {
        substituters = ["https://niri.cachix.org"];
        trusted-substituters = ["https://niri.cachix.org"];
        trusted-public-keys = ["niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="];
      };
    };
  }
