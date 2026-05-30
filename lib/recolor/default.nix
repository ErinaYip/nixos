{
  pkgs,
  config,
  ...
} @ args: let
  recolorOptions = args.recolorOptions or {};
  recolorConfig = {
    mode = "palette";
    colors = config.lib.stylix.colors.withHashtag.toList;
    smooth = true;
    whitelist = [];
  } // recolorOptions;
  basic-colormath = pkgs.python3.pkgs.buildPythonPackage rec {
    pname = "basic-colormath";
    version = "0.5.0";
    pyproject = true;

    src = pkgs.fetchPypi {
      inherit version;
      pname = "basic_colormath";
      hash = "sha256-p/uNuNg5kqKIkeMmX5sWY8umGAg0E4/otgQxhzIuo0E=";
    };

    propagatedBuildInputs = with pkgs.python3.pkgs; [
      setuptools
      setuptools-scm
      pillow
    ];
  };
  pythonEnv = pkgs.python3.withPackages (
    ps:
      with ps; [
        basic-colormath
        colormath
        tqdm
        pillow
      ]
  );
in
  with recolorConfig; {
    recolorScript = ''
      ${pythonEnv}/bin/python ${./recolor.py} --src $out/share/icons \
        --smooth '${toString smooth}' \
        ${
        if whitelist == []
        then ""
        else "--whitelist '${builtins.concatStringsSep "," whitelist}'"
      } \
        ${
        if mode == "monochrome"
        then "--monochrome '${builtins.concatStringsSep "," colors}'"
        else "--palette ''${builtins.concatStringsSep "," colors}''"
      }
    '';
  }
