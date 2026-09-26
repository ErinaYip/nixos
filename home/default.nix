{
  lib,
  inputs,
  default,
  eriniteLib,
  ...
}: {
  imports =
    [
      ../wallpapers
      inputs.stylix.homeModules.stylix
      inputs.nvf.homeManagerModules.default
      inputs.noctalia.homeModules.default
      inputs.oh-my-rime-nix.homeModules.default
    ]
    ++ eriniteLib.modules ./.;

  config = {
    home = {
      username = lib.mkDefault default.username;
      homeDirectory = lib.mkDefault "/home/${default.username}";
      stateVersion = lib.mkDefault default.homeStateVersion;
    };

    xdg = {
      enable = true;
      mimeApps.enable = true;
    };
  };
}
