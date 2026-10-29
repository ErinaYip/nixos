{pkgs, ...}: let
  # IDA Pro is a commercial, manually installed application. Keep it out of the
  # Nix store and point the wrapper at the local installation directory instead,
  # so updating IDA only means replacing that directory.
  installDir = "/home/era/Applications/ida-pro-9.3";

  # IDAPython needs a real libpython shared object; IDA does not bundle one on
  # Linux. `idapyswitch` records the chosen library in ~/.idapro/ida.reg.
  idaPython = pkgs.python312.withPackages (ps: with ps; [requests rpyc]);

  idaLibraries = with pkgs; [
    stdenv.cc.cc
    zlib
    glib
    libGL
    libxkbcommon
    fontconfig
    freetype
    dbus
    libsecret
    openssl
    libkrb5

    wayland

    libxcb
    libx11
    libxi
    libxrender
    libsm
    libice
    libxcb-util
    libxcb-image
    libxcb-keysyms
    libxcb-render-util
    libxcb-wm
    xcbutilcursor
  ];

  ida = pkgs.writeShellApplication {
    name = "ida";
    text = ''
      ida_home="${installDir}"
      libpython="${idaPython}/lib/libpython3.12.so"

      if [ ! -x "$ida_home/ida" ]; then
        echo "ida: IDA Pro installation not found in $ida_home" >&2
        exit 1
      fi

      # IDA ships its own Qt 6 in the installation directory ($ORIGIN runpath),
      # so only the system libraries it does not bundle are added here.
      export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath idaLibraries}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
      export QT_PLUGIN_PATH="$ida_home/plugins:$ida_home/plugins/platforms"
      export QT_QPA_PLATFORM_PLUGIN_PATH="$ida_home/plugins/platforms"

      # libpython resolves to the base interpreter, so expose the extra
      # site-packages (requests, rpyc) of the wrapped Python environment.
      export PYTHONPATH="${idaPython}/lib/python3.12/site-packages''${PYTHONPATH:+:$PYTHONPATH}"

      # Keep IDAPython pointing at the pinned Nix Python after garbage
      # collection or Python updates.
      if [ -x "$ida_home/idapyswitch" ] && [ -e "$libpython" ]; then
        "$ida_home/idapyswitch" --force-path "$libpython" >/dev/null 2>&1 || true
      fi

      exec "$ida_home/ida" "$@"
    '';
  };
in {
  home.packages = [ida];

  xdg.desktopEntries.ida-pro = {
    name = "IDA Pro 9.3";
    genericName = "Disassembler and debugger";
    comment = "Interactive disassembler running from the local IDA Pro installation";
    exec = "ida %f";
    icon = "${installDir}/appico.png";
    terminal = false;
    categories = ["Development" "Debugger"];
    mimeType = ["application/x-executable" "application/x-sharedlib"];
    settings.StartupWMClass = "ida";
  };
}
