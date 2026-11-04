{eriniteLib, ...} @ args: let
in
  eriniteLib.mkModule args {
    configFn = _: {
      programs.linuxqq-wayland-fix = {
        enable = true;
      };
    };
  }
