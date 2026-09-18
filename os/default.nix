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
      inputs.denial.nixosModules.denial
      ../wallpapers
    ]
    ++ eriniteLib.modules ./.;

  config.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit inputs pkgs hostName default eriniteLib;
      isNixosHome = true;
    };
  };
}
