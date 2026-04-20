{
  lib,
  inputs,
  ...
} @ args:

with lib.erinite; mkModule args {
  category = "cli";
  name = "nvim";

  configFn = { settings, ... }: {
    home-manager.sharedModules = [ inputs.erina-vim.homeModules.default ];

    erinite.home.programs.erina-vim = {
      enable = true;
    };

    environment.shellAliases = {
      vim = "nvim";
      V = "nvim";
    };
  };
}
