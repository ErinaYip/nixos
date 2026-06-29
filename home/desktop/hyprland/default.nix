{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    configFn = _: {
      programs.hyprshot = {
        enable = true;
        package = with pkgs; (hyprshot.overrideAttrs (_: {
          src = fetchFromGitHub {
            owner = "erinayip";
            repo = "hyprshot";
            rev = "c2f506b849a24e60b6fe94aec943d913f23b6175";
            hash = "sha256-wVHCzs/OXaVfl3Trruc3uAxSiz4PLKylslsUTUoyZbE=";
          };
        }));
        saveLocation = "$HOME/Pictures/Screenshots";
      };

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
