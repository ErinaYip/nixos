{
  plugin.touch_gestures = {
    sensitivity = 4.0;
    resize_on_border_long_press = true;

    workspace_swipe_fingers = 3;

    # switching workspaces by swiping from an edge, this is separate from workspace_swipe_fingers
    # and can be used at the same time
    # possible values: l, r, u, or d
    # to disable it set it to anything else
    workspace_swipe_edge = "d";

    long_press_delay = 400;

    # in pixels, the distance from the edge that is considered an edge
    edge_margin = 10;
  };
}
