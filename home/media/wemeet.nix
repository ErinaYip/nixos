{
  pkgs,
  eriniteLib,
  ...
} @ args: let
  # eglVendorFile = "${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json";
  # wrapProgram "$out/bin/wemeet" \
  #   --set __EGL_VENDOR_LIBRARY_FILENAMES ${eglVendorFile}
  # wrapProgram "$out/bin/wemeet-xwayland" \
  #   --set __EGL_VENDOR_LIBRARY_FILENAMES ${eglVendorFile}
  wemeet = pkgs.wemeet.overrideAttrs (oldAttrs: {
    postFixup =
      (oldAttrs.postFixup or "")
      + ''
        substituteInPlace "$out/share/applications/wemeetapp.desktop" \
          --replace-fail 'Exec=wemeet %u' 'Exec=wemeet-xwayland %u'
      '';
  });
in
  eriniteLib.mkModule args {
    configFn = _: {
      home.packages = [wemeet];
    };
  }
