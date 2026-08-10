{
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args: let
  niriPackages = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system};
in
  with eriniteLib;
    mkModule args {
      configFn = _: {
        programs.niri = {
          enable = true;
          package = niriPackages.niri-unstable;
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
