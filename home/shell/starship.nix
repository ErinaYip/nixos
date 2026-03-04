{ config, ... }: {
  programs.starship = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableFishIntegration = config.programs.fish.enable;
    enableZshIntegration = config.programs.zsh.enable;
    settings = {
      add_newline = true;
      # command_timeout = 1300;
      # scan_timeout = 50;
      character = {
        success_symbol = "[›](bold green) ";
        error_symbol = "[›](bold red) ";
      };
    };
  };
}