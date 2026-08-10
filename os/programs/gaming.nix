{
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    nixpkgs.overlays = [inputs.millennium.overlays.default];

    programs = {
      gamemode.enable = true;
      gamescope = {
        enable = true;
        capSysNice = false;
      };

      steam = {
        enable = true;
        package = pkgs.millennium-steam;
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
