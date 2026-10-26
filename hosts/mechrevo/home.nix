{pkgs, ...}: let
  eDP = "China Star Optoelectronics Technology Co. Ltd MNG007DA5-4";
  DP = "HKC OVERSEAS LIMITED X5 0000000000001";
in {
  home.packages = with pkgs; [
    # materialgram
  ];

  wayland.windowManager.hyprland.extraConfig = ''
    local eDP = "${eDP}"
    local DP  = "${DP}"

    hl.monitor({
      output = "desc:" .. eDP,
      mode = "2560x1600@180.00Hz",
      position = "0x0",
      scale = 1.6,
      transform = 0,
    })

    hl.monitor({
      output = "desc:" .. DP,
      mode = "1920x1080@260.00Hz",
      position = "1600x0",
      scale = 1,
      transform = 0,
    })
  '';
}
