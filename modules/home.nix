{
  config,
  lib,
  inputs,
  pkgs,
  hostName,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.home;
in {
  imports = [inputs.home-manager.nixosModules.home-manager];

  options.zenyte.home = with types; {
    enable = mkBoolOpt false "Enable home-manager integration";
    user = mkStrOpt "demo" "Username";
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