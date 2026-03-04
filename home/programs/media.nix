{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    vlc
    gnome-sound-recorder
    kdePackages.kdenlive
    nomacs
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
