{eriniteLib, ...}:
with eriniteLib; {
  programs.cava = enabled;

  wayland.windowManager.hyprland.extraConfig = ''
    local eDP = "China Star Optoelectronics Technology Co. Ltd MNG007DA5-4"
    local DP  = "HKC OVERSEAS LIMITED X5 0000000000001"

    hl.monitor({
      output = "desc:" .. eDP,
      mode = "2560x1600@180.00Hz",
      position = "1920x0",
      scale = 1.6,
      transform = 1,
    })

    hl.monitor({
      output = "desc:" .. DP,
      mode = "1920x1080@260.00Hz",
      position = "0x0",
      scale = 1,
    })

    for _, mon in ipairs(hl.get_monitors()) do
      if mon.description == DP then
        hl.workspace_rule({ workspace = "2", monitor = DP, default = true, })
        hl.workspace_rule({ workspace = "1", monitor = eDP, default = true, layout = "dwindle", })
        break
      end
    end
  '';
}
