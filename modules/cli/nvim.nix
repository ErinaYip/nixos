{
  lib,
  inputs,
  ...
} @ args:

with lib.erinite; mkModule args {
  category = "cli";
  name = "nvim";

  configFn = { settings, ... }: lib.mkMerge [
    {
      home-manager.sharedModules = [ inputs.erina-vim.homeModules.default ];

      erinite.home.programs.erina-vim = {
        enable = true;
      };
    }

    (mkShellAliases {
      aliases = {
        vim = "nvim";
        V = "nvim";
      };
      shells = [ "zsh" ];
    })
  ];
}
