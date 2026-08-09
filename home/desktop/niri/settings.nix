{
  lib,
  pkgs,
  ...
}: {
  prefer-no-csd = true;
  xwayland-satellite.path = "${lib.getExe pkgs.xwayland-satellite-unstable}";

  layout = {
    gaps = 2;
    struts.left = 16;
    struts.right = 16;
    always-center-single-column = true;
    background-color = "transparent";

    default-column-width = {
      proportion = 0.8;
    };

    preset-column-widths = builtins.genList (i: {proportion = (i + 1) * 2.0 / 7.0;}) 3;
    # [
    #   {proportion = 1.0 / 3.0;}
    #   {proportion = 1.0 / 2.0;}
    #   {proportion = 2.0 / 3.0;}
    #   {proportion = 3.0 / 4.0;}
    #   {proportion = 4.0 / 5.0;}
    # ];

    # tab-indicator = {
    #   gap = 2;
    #   width = 3;
    #   gaps-between-tabs = 2;
    #   corner-radius = 12;
    # };

    border = {
      enable = true;
      width = 3;
    };

    focus-ring = {
      width = 3;
    };

    # shadow.enable = true;
  };

  input = {
    keyboard = {
      repeat-delay = 400;
      repeat-rate = 30;
    };
  };
}
