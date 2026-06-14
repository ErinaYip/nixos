{
  lib,
  inputs,
  default,
  eriniteLib,
  ...
}: {
  imports =
    [
      inputs.stylix.homeModules.stylix
      inputs.nvf.homeManagerModules.default
      inputs.dms.homeModules.dank-material-shell
      inputs.dms-plugin-registry.homeModules.default
      inputs.oh-my-rime-nix.homeModules.default
    ]
    ++ eriniteLib.modules ./.;

  config = {
    home = {
      username = lib.mkDefault default.username;
      homeDirectory = lib.mkDefault "/home/${default.username}";
      stateVersion = lib.mkDefault default.homeStateVersion;
    };

    xdg.enable = lib.mkDefault true;
  };
}
