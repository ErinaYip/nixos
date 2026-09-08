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
      hash = "sha256-ay4g5wAGNy6N37rkDqhkVkUgyHsH0BYLYA7JP3j9XMI=";
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
        mkdir -p $out/share/icons/hicolor/256x256/apps

        cp ${appimageContents}/wechat.png $out/share/icons/hicolor/256x256/apps/ || true
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

      xdg.desktopEntries.wechat = {
        name = "WeChat";
        genericName = "WeChat";
        exec = "env WAYLAND_DISPLAY= DISPLAY=:0 QT_QPA_PLATFORM=xcb GTK_IM_MODULE=fcitx QT_IM_MODULE=fcitx XMODIFIERS=@im=fcitx wechat %U";
        icon = "wechat";
        terminal = false;
        type = "Application";
        categories = ["Network" "InstantMessaging"];
        comment = "WeChat Desktop";
      };
    };
  }
