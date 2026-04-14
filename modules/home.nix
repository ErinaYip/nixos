{
  config,
  lib,
  inputs,
  ...
}:
with lib; {
  imports = [inputs.home-manager.nixosModules.home-manager];

  options.demo = with types; {
    user.name = mkOption {
      type = str;
      default = "demo";
      description = "Primary user name for this host.";
    };

    home.extraOptions = mkOption {
      type = attrs;
      default = {};
      description = "Additional Home Manager options.";
    };
  };

  config = {
    home-manager.useGlobalPkgs = true;

    home-manager.users.${config.demo.user.name} = {
      home.username = config.demo.user.name;
      home.homeDirectory = "/home/${config.demo.user.name}";
      home.stateVersion = config.system.stateVersion;
      programs.home-manager.enable = true;
    } // config.demo.home.extraOptions;
  };
}
