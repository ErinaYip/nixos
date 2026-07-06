{
  pkgs,
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
    programs = {
      gamemode.enable = true;
      gamescope = {
        enable = true;
        capSysNice = false;
      };

      steam = {
        enable = true;
        extraPackages = with pkgs; [
          mangohud
          pulseaudio
        ];
        gamescopeSession = {
          enable = true;
          inherit (settings.gamescopeSession) args steamArgs;
        };
      };
    };
  };
}
