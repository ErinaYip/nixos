{
  homeOnly = [
    "starship"
    "bat"
    "zsh"
    "fish"
    "alacritty"
    "kitty"
    "fzf"
    "exa"
    "delta"
    "direnv"
  ];

  nixosOnly = [
    "docker"
    "bluetooth"
    "virtualisation"
    "podman"
    "flatpak"
  ];

  both = [
    "git"
    "vim"
    "tmux"
    "neovim"
  ];
}