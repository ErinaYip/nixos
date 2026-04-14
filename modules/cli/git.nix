{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.demo; let
  cfg = config.demo.cli.git;
in {
  options.demo.cli.git = with types; {
    enable = mkBoolOpt false "Whether to enable the git demo module.";
    userName = mkOpt str "Demo User" "Git user name.";
    userEmail = mkOpt str "demo@example.com" "Git user email.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.git];

    demo.home.extraOptions = {
      programs.git = {
        enable = true;
        userName = cfg.userName;
        userEmail = cfg.userEmail;
      };
    };
  };
}
