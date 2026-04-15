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

  options.erinite.home.config = lib.mkOption {
    type = lib.types.attrs;
    default = {};
    description = "Home Manager config pass-through.";
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = { inherit inputs default; };

      users.${default.username} = _: lib.mkMerge [
        {
          home.stateVersion = config.system.stateVersion;
          xdg.enable = true;
        }

        config.erinite.home.config
      ];
    };
  };
}
