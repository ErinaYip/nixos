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
      {proportion = 1. / 4.;}
      {proportion = 1. / 3.;}
      {proportion = 2. / 4.;}
      {proportion = 2. / 3.;}
      {proportion = 3. / 4.;}
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
      repeat-delay = 300;
      repeat-rate = 40;
    };

    warp-mouse-to-focus.enable = true;
    focus-follows-mouse = {
      enable = true;
      max-scroll-amount = "0%";
    };

    mouse = {
      accel-speed = 0.0;
      accel-profile = "flat";
    };

    touchpad = {
      tap = true;
      accel-speed = 0.0;
      natural-scroll = true;
      dwt = true;
    };
  };

  cursor = {
    theme = "Bibata-Modern-Ice";
    size = 24;
  };
}
