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
    settings.user = {
      name = mkOpt str "Demo User" "Git user name.";
      email = mkOpt str "demo@example.com" "Git user email.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.git];

    demo.home.extraOptions = {
      programs.git = {
        enable = true;
        settings = cfg.settings;
      };
    };
  };
}
