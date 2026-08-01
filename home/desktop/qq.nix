{
  pkgs,
  eriniteLib,
  ...
} @ args: let
  qq = pkgs.qq.overrideAttrs (oldAttrs: {
    version = "universal";

    src = pkgs.fetchurl {
      url = "https://qqdl.gtimg.cn/qqfile/QQNT/9.9.33/release/c97651b2/QQ_3.2.32_260730_amd64_01.deb";
      hash = "sha256-ga4rhULvUxH8cuz1PJpSOSPINFacew2lLgv0Nguctfk=";
    };

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
