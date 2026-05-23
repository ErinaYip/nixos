{
  inputs,
  default,
  hostName,
  eriniteLib,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
    ]
    ++ eriniteLib.modules ./.;

  config.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit inputs hostName default eriniteLib;
    };
  };
}
