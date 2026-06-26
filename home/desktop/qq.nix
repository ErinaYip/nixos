{
  pkgs,
  eriniteLib,
  ...
} @ args: let
  qq = pkgs.qq.overrideAttrs (oldAttrs: {
    postFixup =
      (oldAttrs.postFixup or "")
      + ''
        substituteInPlace "$out/share/applications/qq.desktop" \
          --replace-fail \
            "Icon=$out/share/icons/hicolor/512x512/apps/qq.png" \
            "Icon=qq"
      '';
  });
in
  eriniteLib.mkModule args {
    configFn = _: {
      home.packages = [qq];
    };
  }
