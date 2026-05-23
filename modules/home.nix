{
  config,
  lib,
  default,
  inputs,
  ...
}: let
  baseHomeModule = {
    home = {
      username = lib.mkDefault default.username;
      homeDirectory = lib.mkDefault "/home/${default.username}";
      stateVersion = lib.mkDefault default.homeStateVersion;
    };
    xdg.enable = lib.mkDefault true;
  };
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.erinite = {
    home = lib.mkOption {
      type = lib.types.deferredModule;
      default = {};
      description = "Home Manager module pass-through.";
    };

    homeModule = lib.mkOption {
      type = lib.types.deferredModule;
      readOnly = true;
      description = "Composed Home Manager module for NixOS and standalone Home Manager entrypoints.";
    };
  };

  config = {
    erinite.homeModule = {
      imports = [
        baseHomeModule
        config.erinite.home
      ];
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {
        inherit inputs default;
      };

      users.${default.username} = {
        imports = [config.erinite.homeModule];
      };
    };
  };
}
