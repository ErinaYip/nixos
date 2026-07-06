{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    configFn = _: {
      home.packages = with pkgs; [
        (hyprshot.overrideAttrs (_: {
          src = fetchFromGitHub {
            owner = "erinayip";
            repo = "hyprshot";
            rev = "2f2e696cb37e96788222b7a3fb548b8b928b375c";
            hash = "sha256-0NAL/Dr403gjVFTORldcRGClYATrVeoufqIw0C2TUds=";
          };
        }))
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        configType = "lua";
        systemd.enable = false;
        settings = lib.mkMerge [
          (import ./binds.nix {inherit lib;})
          (import ./rules.nix)
          (import ./settings.nix)
          (import ./dynamic-cursors.nix)
        ];

        package = mkInputPkga "hyprland";
        plugins = [
          (mkInputPkga "hypr-dynamic-cursors")
        ];
      };

      xdg.portal = {
        enable = true;
        config.hyprland.preferred = ["hyprland" "gtk"];
      };

      services.hypridle = {
        enable = true;
        settings = {
          general.after_sleep_cmd = "hyprctl dispatch dpms on";
          listener = [
            {
              timeout = 360;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
          ];
        };
      };
    };
  }
