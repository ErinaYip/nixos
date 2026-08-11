{
  lib,
  pkgs,
  inputs,
  ...
}: let
  niriPackages = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system};
in {
  prefer-no-csd = true;
  xwayland-satellite.path = "${lib.getExe niriPackages.xwayland-satellite-unstable}";

  layout = {
    gaps = 2;
    struts.left = 6;
    struts.right = 6;
    always-center-single-column = true;
    background-color = "transparent";

    default-column-width = {
      proportion = 0.8;
    };

    preset-column-widths = [
      {proportion = 0.2;}
      {proportion = 0.4;}
      {proportion = 0.5;}
      {proportion = 0.6;}
      {proportion = 0.8;}
    ];

    border = {
      enable = true;
      width = 3;
    };

    focus-ring = {
      width = 3;
    };
  };

  input = {
    keyboard = {
      repeat-delay = 400;
      repeat-rate = 30;
    };

    warp-mouse-to-focus.enable = true;
    focus-follows-mouse.enable = true;

    mouse = {
      accel-speed = 0.0;
    };

    touchpad = {
      tap = true;
      accel-speed = 0.0;
      natural-scroll = true;
      dwt = true;
    };
  };
}
