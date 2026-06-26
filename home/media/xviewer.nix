{
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    configFn = _: {
      home.packages = with pkgs; [
        xviewer
      ];

      xdg.mimeApps.defaultApplications = mkDefaultApplications "xviewer.desktop" [
        "image/bmp"
        "image/gif"
        "image/jpeg"
        "image/jpg"
        "image/pjpeg"
        "image/png"
        "image/tiff"
        "image/x-bmp"
        "image/x-gray"
        "image/x-icb"
        "image/x-ico"
        "image/x-png"
        "image/x-portable-anymap"
        "image/x-portable-bitmap"
        "image/x-portable-graymap"
        "image/x-portable-pixmap"
        "image/x-xbitmap"
        "image/x-xpixmap"
        "image/x-pcx"
        "image/svg+xml"
        "image/svg+xml-compressed"
        "image/vnd.wap.wbmp"
        "image/webp"
        "image/heif"
        "image/avif"
      ];
    };
  }
