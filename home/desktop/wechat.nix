{
  pkgs,
  eriniteLib,
  ...
} @ args: let
  wechat = let
    pname = "wechat";
    version = "universal";

    src = pkgs.fetchurl {
      url = "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage";
      hash = "sha256-vTTkuFm1LhAqVvuynIfYdROPf19nfCQIOGhw6Z+dOeo=";
    };

    appimageContents = pkgs.appimageTools.extract {
      inherit pname version src;
      postExtract = ''
        if [ -f $out/opt/wechat/wechat ]; then
          patchelf --replace-needed libtiff.so.5 libtiff.so $out/opt/wechat/wechat || true
        fi
      '';
    };
  in
    pkgs.appimageTools.wrapAppImage {
      inherit pname version;

      src = appimageContents;

      extraInstallCommands = ''
        mkdir -p $out/share/applications
        mkdir -p $out/share/icons/hicolor/256x256/apps

        cp ${appimageContents}/wechat.desktop $out/share/applications/
        cp ${appimageContents}/wechat.png $out/share/icons/hicolor/256x256/apps/ || true

        substituteInPlace $out/share/applications/wechat.desktop \
          --replace-fail "AppRun" "wechat" \
          --replace-fail \
            "Name[zh_CN]=微信" \
            "Name[zh_CN]=wechat"
      '';

      meta = {
        description = "WeChat Official Linux Universal AppImage";
        homepage = "https://linux.weixin.qq.com/";
        platforms = ["x86_64-linux"];
      };
    };
in
  eriniteLib.mkModule args {
    configFn = _: {
      home.packages = [wechat];
    };
  }
