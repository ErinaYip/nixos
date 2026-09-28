{
  inputs,
  pkgs,
  default,
  hostName,
  eriniteLib,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ../wallpapers
    ]
    ++ eriniteLib.modules ./.;

  config.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit inputs pkgs hostName default eriniteLib;
    };
  };
}
