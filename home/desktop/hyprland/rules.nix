{ ... }: {
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "opacity 0.9, match:focus true"
      "opacity 0.8, match:focus false"
      # pseudo, class:^(fcitx)$

      "float true, match:initial_title .*float.*"
      "center true, match:initial_title .*float.*"
      "size 50% 50%, match:initial_title .*float.*"

      "no_blur on, match:fullscreen true"
      "opacity 1.0, match:fullscreen true"
    ];
  };
}
