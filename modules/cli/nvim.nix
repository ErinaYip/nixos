{
  lib,
  inputs,
  eriniteLib,
  ...
} @ args:

with eriniteLib; mkModule args {
  category = "cli";
  name = "nvim";

  configFn = { settings, ... }: lib.mkMerge [
    {
      home-manager.sharedModules = [ inputs.erina-vim.homeModules.default ];

      erinite.home.programs.erina-vim = {
        enable = true;
      };

      environment.sessionVariables = {
        EDITOR = lib.mkDefault "nvim";
        VISUAL = lib.mkDefault "nvim";
        GIT_EDITOR = lib.mkDefault "nvim";
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
