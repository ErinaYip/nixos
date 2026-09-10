{
  prefer-no-csd = {};

  layout = {
    gaps = 2;
    struts.left = 6;
    struts.right = 6;
    always-center-single-column = {};
    background-color = "transparent";

    default-column-width = {
      proportion = 0.8;
    };

    preset-column-widths._children = [
      {proportion = 1. / 4.;}
      {proportion = 1. / 3.;}
      {proportion = 2. / 4.;}
      {proportion = 2. / 3.;}
      {proportion = 3. / 4.;}
    ];

    border = {
      on = {};
      width = 3;
    };

    focus-ring = {
      width = 3;
    };
  };

  input = {
    keyboard = {
      repeat-delay = 300;
      repeat-rate = 40;
    };

    warp-mouse-to-focus = {};
    focus-follows-mouse = {
      _props.max-scroll-amount = "0%";
    };

    mouse = {
      accel-speed = 0.0;
      accel-profile = "flat";
    };

    touchpad = {
      tap = {};
      accel-speed = 0.0;
      natural-scroll = {};
      dwt = {};
    };
  };

  cursor = {
    xcursor-theme = "Bibata-Modern-Ice";
    xcursor-size = 24;
  };
}
