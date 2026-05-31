{
  pkgs,
  eriniteLib,
  ...
} @ args: let
  wechat = pkgs.wechat.overrideAttrs (oldAttrs: {
    buildCommand =
      oldAttrs.buildCommand
      + ''
        substituteInPlace "$out/share/applications/wechat.desktop" \
          --replace-fail \
            "Exec=wechat %U" \
            "Exec=env XCURSOR_THEME=Bibata-Modern-Ice XCURSOR_SIZE=24 wechat --ozone-platform=wayland --force-device-scale-factor=1.6 %U" \
          --replace-fail \
            "Name[zh_CN]=微信" \
            "Name[zh_CN]=wechat"
      '';
  });
in
  eriniteLib.mkModule args {
    namespace = ["erinite" "home"];
    category = "desktop";
    name = "wechat";

    configFn = _: {
      home.packages = [wechat];
    };
  }
