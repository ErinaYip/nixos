{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.erinite.cli.git;
in {
  options.erinite.cli.git = {
    enable = lib.erinite.mkBoolOpt false "Enable git.";
    user = {
      name = lib.erinite.mkStrOpt "Demo User" "Git user name.";
      email = lib.erinite.mkStrOpt "demo@example.com" "Git user email.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.git];

    programs.git = {
      enable = true;
    };
  };
}