{
  config,
  lib,
  ...
}:
let
  cfg = config.erinite.home;
in {
  options.erinite.home = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable home-manager integration.";
    };
    username = lib.mkOption {
      type = lib.types.str;
      default = "demo";
      description = "Username for home-manager.";
    };
    config = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Home Manager config pass-through.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${cfg.username} = _: lib.mkMerge [
        {
          home.username = cfg.username;
          home.homeDirectory = "/home/${cfg.username}";
          home.stateVersion = config.system.stateVersion;
          xdg.enable = true;
        }
        cfg.config
      ];
    };
  };
}