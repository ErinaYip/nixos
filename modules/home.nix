{
  config,
  lib,
  default,
  inputs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.erinite.home = lib.mkOption {
    type = lib.types.deferredModule;
    default = {};
    description = "Home Manager module pass-through.";
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = { inherit inputs default; };

      users.${default.username} = {
        imports = [
          {
            home.stateVersion = default.homeStateVersion;
            xdg.enable = true;
          }

          config.erinite.home
        ];
      };
    };
  };
}
