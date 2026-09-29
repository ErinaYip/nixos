{
  bar.main = {
    capsule = true;
    background_opacity = 0.9;
    color = "primary";
    icon_color = "secondary";
    margin_ends = 0;
    radius = 80;
    radius_top_left = 0;
    radius_top_right = 0;

    start = [
      "launcher"
      "group:performance"
      "group:network"
      "network"
      "bluetooth"
      "active_window"
    ];

    center = [
      "taskbar"
      "clock"
      "media"
      "audio_visualizer"
    ];

    end = [
      "tray"
      "notifications"
      "clipboard"
      "volume"
      "brightness"
      "battery"
      "session"
    ];

    capsule_group = [
      {
        id = "network";
        members = ["network_tx" "network_rx"];
      }

      {
        id = "performance";
        members = ["cpu" "ram"];
      }
    ];
  };

  bar.sub = {
    enabled = false;
    capsule = true;
    background_opacity = 0.9;
    color = "primary";
    icon_color = "secondary";

    start = [
      "taskbar"
      "active_window"
    ];

    center = [
      "media"
      "audio_visualizer"
    ];

    end = [
      "tray"
      "notifications"
      "caffeine"
      "bluetooth"
      "power_profile"
      "brightness"
    ];

    capsule_group = [
      {
        id = "network";
        members = ["network_tx" "network_rx"];
      }

      {
        id = "performance";
        members = ["cpu" "ram"];
      }
    ];
  };

  widget = {
    clock = {
      format = "{:%H:%M :%a :%m:%d}";
      actions.left = "panel-toggle control-center home";
      anchor = true;
    };

    launcher = {
      glyph = "menu-2";
    };

    taskbar = {
      group_by_workspace = true;
      group_single_icon_per_app = true;
      icon_scale = 2.0;
      workspace_label_placement = "corner";
    };

    media = {
      hide_when_no_media = true;
    };
  };
}
