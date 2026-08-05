{
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  defaultSettings = {
    gamescopeSession = {
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

  configFn = {settings, ...}: {
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
        # extraPackages = with pkgs; [
        #   mangohud
        #   pulseaudio
        # ];
        gamescopeSession = {
          enable = true;
          inherit (settings.gamescopeSession) args steamArgs;
        };
      };
    };
  };
}
