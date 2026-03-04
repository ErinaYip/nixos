{ ... }: {
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "opacity 0.9, match:focus true"
      "opacity 0.8, match:focus false"
      # pseudo, class:^(fcitx)$

      "float true, match:class .*float.*"
      "center true, match:class .*float.*"
      "size 50% 50%, match:class .*float.*"

      "no_blur on, match:fullscreen true"
      "opacity 1.0, match:fullscreen true"
    ];

    workspace = [
      "10, persistent:true"
    ];
  };
}
