{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.demo.home;
in {
  options.demo.home = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable home-manager.";
    };
    user = lib.mkOption {
      type = lib.types.str;
      default = "demo";
      description = "Username.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.useGlobalPkgs = true;
    home-manager.users.${cfg.user} = {
      home.username = cfg.user;
      home.homeDirectory = "/home/${cfg.user}";
      home.stateVersion = config.system.stateVersion;
      xdg.enable = true;
    };
    environment.systemPackages = [pkgs.home-manager];
  };
}