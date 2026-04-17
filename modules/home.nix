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
<<<<<<< HEAD
          home.stateVersion = default.homeStateVersion;
=======
          home.stateVersion = config.system.stateVersion;
>>>>>>> origin/main
          xdg.enable = true;
        }

        config.erinite.home
      ];
    };
  };
}
