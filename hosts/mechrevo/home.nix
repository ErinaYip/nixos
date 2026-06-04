{eriniteLib, ...}:
with eriniteLib; {
  programs.cava = enabled;

  wayland.windowManager.hyprland.extraConfig = ''
    local eDP = "desc:China Star Optoelectronics Technology Co. Ltd MNG007DA5-4"
    local DP  = "desc:HKC OVERSEAS LIMITED X5 0000000000001"

    local has_ext = false
    for _, mon in ipairs(hl.get_monitors()) do
      if mon.description == "HKC OVERSEAS LIMITED X5 0000000000001" then
        has_ext = true
        hl.workspace_rule({ workspace = "2", monitor = DP, default = true, })
        hl.workspace_rule({ workspace = "1", monitor = eDP, default = true, layout = "dwindle", })
        break
      end
    end

    hl.monitor({
      output = eDP,
      mode = "2560x1600@180.00Hz",
      position = "1920x0",
      scale = 1.6,
      transform = has_ext and 1 or 0,
    })

    hl.monitor({
      output = DP,
      mode = "1920x1080@260.00Hz",
      position = "0x0",
      scale = 1,
    })
  '';
}
