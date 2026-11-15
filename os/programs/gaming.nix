{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    programs = {
      gamemode.enable = true;
      gamescope = {
        enable = true;
        capSysNice = false;
      };

      steam = {
        enable = true;
        gamescopeSession = {
          enable = true;
          args = [
            "-f"
            "--filter"
            "fsr"
          ];
          steamArgs = [
            "-tenfoot"
            "-pipewire-dmabuf"
          ];
        };
      };
    };
  };
}
