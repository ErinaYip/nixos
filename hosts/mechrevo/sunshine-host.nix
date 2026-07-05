{
  lib,
  pkgs,
  default,
  ...
}: {
  specialisation.sunshine-host.configuration = {
    erinite.os = {
      system = {
        nvidia.enable = lib.mkForce false;
      };

      desktop = {
        streaming = {
          enable = true;
          host = {
            enable = true;
            autoStart = false;
          };
        };
      };
    };

    home-manager.users.${default.username} = {
      wayland.windowManager.hyprland.extraConfig = lib.mkAfter ''
        hl.env("AQ_NO_KMS_REQUIREMENT", "1")

        hl.monitor({ output = "desc:" .. eDP, disabled = true, })
        hl.monitor({ output = "desc:" .. DP, disabled = true, })

        hl.monitor({
          output = "HEADLESS-0",
          mode = "1920x1080@60.00Hz",
          position = "0x0",
          scale = 1,
        })

        hl.on("hyprland.start", function ()
          hl.exec_cmd("hyprctl output create headless HEADLESS-0")
          hl.exec_cmd("sunshine")
        end)
      '';

      erinite.home. desktop.dms.bars = {
        mainBar.screenPreferences = lib.mkForce ["HEADLESS-0"];
        subBar.enabled = false;
      };
    };
  };
}
