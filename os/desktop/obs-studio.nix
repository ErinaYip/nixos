{
  pkgs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;

      plugins = with pkgs.obs-studio-plugins; [
        # wlrobs
        # obs-pipewire-audio-capture
        # obs-backgroundremoval
        # obs-gstreamer
        obs-vkcapture
      ];
    };
  };
}
