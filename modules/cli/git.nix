{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.demo.cli.git;
in {
  options.demo.cli.git = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable git.";
    };
    user = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "Demo User";
        description = "Git user name.";
      };
      email = lib.mkOption {
        type = lib.types.str;
        default = "demo@example.com";
        description = "Git user email.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.git];
    programs.git.enable = true;
  };
}