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
    struts.left = 16;
    struts.right = 16;
    always-center-single-column = true;
    background-color = "transparent";

    default-column-width = {
      proportion = 0.8;
    };

    preset-column-widths = builtins.genList (i: {proportion = (i + 1) * 2.0 / 7.0;}) 3;

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
  };
}
