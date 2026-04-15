{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.cli.git;
in {
  options.zenyte.cli.git = with types; {
    enable = mkBoolOpt false "Whether to enable the git module.";
    settings.user = {
      name = mkStrOpt "Demo User" "Git user name.";
      email = mkStrOpt "demo@example.com" "Git user email.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.git];

    programs.git.enable = true;
  };
}
