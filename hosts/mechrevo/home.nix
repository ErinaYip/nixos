{
  pkgs,
  eriniteLib,
  ...
}:
with eriniteLib; let
  eDP = "China Star Optoelectronics Technology Co. Ltd MNG007DA5-4";
  DP = "HKC OVERSEAS LIMITED X5 0000000000001";
in {
  home.packages = with pkgs; [
    materialgram
    wemeet
  ];

  wayland.windowManager.niri.settings = {
    _children = [
      {
        output = {
          _args = [eDP];
          mode._args = ["2560x1600@180.000"];
          position._props = {
            x = 1920;
            y = 0;
          };
          scale = 1.6;
        };
      }
      {
        output = {
          _args = [DP];
          mode._args = ["1920x1080@260.000"];
          position._props = {
            x = 0;
            y = 0;
          };
          scale = 1;
        };
      }

      {
        spawn-sh-at-startup._args = [
          ''
              outputs=$(niri msg outputs) || exit 0

            eDP_output=$(printf '%s\n' "$outputs" | grep -m1 "${eDP}" | sed 's/.*(\(.*\)).*/\1/')
              [ -z "$eDP_output" ] && exit 0

            printf '%s\n' "$outputs" | grep -q "${DP}" && rot="90" || rot="normal"
              niri msg output "$eDP_output" transform "$rot"
          ''
        ];
      }
    ];
  };

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

    for _, mon in ipairs(hl.get_monitors()) do
      if mon.description == DP then
        hl.workspace_rule({ workspace = "2", monitor = DP, default = true, })
        hl.workspace_rule({ workspace = "1", monitor = eDP, default = true, layout = "dwindle", })

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

        break
      end
    end
  '';
}
