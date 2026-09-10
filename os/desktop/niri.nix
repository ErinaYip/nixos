{
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    configFn = _: {
      programs.niri = {
        enable = true;
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
    };
  }
