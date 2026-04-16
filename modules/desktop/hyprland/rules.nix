{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "opacity 0.9, match:focus true, fullscreen false"
      "opacity 0.8, match:focus false, fullscreen false"

      "float true, match:initial_title .*float.*"
      "float true, match:initial_title .*图片和视频.*"
      "float true, match:initial_title .*图片查看器.*"
      "float true, match:initial_title .*画中画.*"
      "float true, match:initial_title .*打开文件.*"
    ];

    workspace = [
      "1, monitor:DP-2,      default:true"
      "2, monitor:eDP-1,     default:true"
      "9, monitor:Virtual-1, default:true"
      "2, layout:dwindle"
    ];
  };
}
