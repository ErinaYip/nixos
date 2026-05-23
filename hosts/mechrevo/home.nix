{eriniteLib, ...}: with eriniteLib; {
  programs.cava = enabled;

  wayland.windowManager.hyprland = {
    extraConfig = ''
      local is_ext = false
      for _, mon in ipairs(hl.get_monitors()) do
          if mon.name == "DP-2" or mon.name == "DP-3" then
              is_ext = true
              break
          end
      end

      for _, name in ipairs({"eDP-1", "eDP-2"}) do
          hl.monitor({
              output = name,
              mode = "2560x1600@180.00Hz",
              position = "1920x0",
              scale = "1.6",
              transform = is_ext and 1 or 0
          })
      end

      for _, name in ipairs({"DP-2", "DP-3"}) do
          hl.monitor({
              output = name,
              mode = "1920x1080@260.00Hz",
              position = "0x0",
              scale = "1"
          })
      end
    '';
    settings = {
      workspace_rule = [
        {
          workspace = "1";
          monitor = "eDP-1";
          default = true;
        }
        {
          workspace = "1";
          monitor = "eDP-2";
          default = true;
        }
        {
          workspace = "1";
          layout = "dwindle";
        }
      ];
    };
  };
}
