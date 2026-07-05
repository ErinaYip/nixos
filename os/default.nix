{
  inputs,
  pkgs,
  pkgsStable,
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
      inherit inputs pkgs pkgsStable hostName default eriniteLib;
      isNixosHome = true;
    };
  };
}
