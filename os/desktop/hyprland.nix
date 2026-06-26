{
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    configFn = {...}: {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
        package = mkInputPkga "hyprland";
        portalPackage = mkInputPkgb "hyprland" "xdg-desktop-portal-hyprland";
      };

      environment = {
        systemPackages = with pkgs; [
          wl-clipboard
          grim
          slurp
        ];

        localBinInPath = true;
        pathsToLink = [
          "/share/applications"
          "/share/xdg-desktop-portal"
        ];
      };

      nix.settings = {
        substituters = [
          "https://hyprland.cachix.org"
        ];
        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        ];
      };
    };
  }
