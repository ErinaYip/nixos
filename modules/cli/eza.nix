{config, lib, pkgs, ...}:
with lib; let
  cfg = config.demo.cli;
in {
  options.demo.cli.eza = mkOption {
    type = types.bool;
    default = false;
    description = "Enable eza - a modern replacement for ls";
  };

  config = mkIf cfg.eza {
    home-manager.users.${config.demo.home.user}.programs.eza = {
      enable = true;
      enableBashIntegration = config.programs.bash.enable or false;
      enableZshIntegration = config.programs.zsh.enable or false;
      enableFishIntegration = config.programs.fish.enable or false;
      extraOptions = [
        "--color=always"
        "--group-directories-first"
        "--header"
        "--time-style=long-iso"
      ];
      git = true;
      icons = "always";
    };
  };
}