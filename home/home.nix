{ config, pkgs, inputs, ... }: {
  imports = [
    ./bar
    ./desktop
    ./filemanager
    ./programs
    ./shell
  ];

  home.username = "era";
  home.homeDirectory = "/home/era";
  home.stateVersion = "26.05";
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      init.defaultBranch = "main";
      user = {
        name = "ErinaYip";
        email = "erinayip@outlook.com";
      };
    };
  };
}
