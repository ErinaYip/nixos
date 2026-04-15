{
  config,
  lib,
  inputs,
  pkgs,
  hostName,
  ...
}:
with lib; let
  cfg = config.demo.home;
in {
  imports = [inputs.home-manager.nixosModules.home-manager];

  options.demo.home = with types; {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable home-manager integration";
    };
    user = mkOption {
      type = types.str;
      default = "demo";
      description = "Username";
    };
    extraOptions = mkOption {
      type = types.attrs;
      default = {};
      description = "Extra home-manager options";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.useGlobalPkgs = true;

    home-manager.users.${cfg.user} = {
      home.username = cfg.user;
      home.homeDirectory = "/home/${cfg.user}";
      home.stateVersion = config.system.stateVersion;

      xdg.enable = true;
    } // cfg.extraOptions;

    environment.systemPackages = [pkgs.home-manager];
  };
}