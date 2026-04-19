{
  lib,
  inputs,
  ...
} @ args:

with lib.erinite; mkModule args {
  category = "cli";
  name = "nvim";

  defaultSettings = {
    modules = {
      dap = {
        enable = false;
        dap-ui = false;
        dap-lldb = false;
      };
    };
  };

  configFn = { settings, ... }: {
    home-manager.sharedModules = [ inputs.erina-vim.homeModules.default ];

    erinite.home.programs.erina-vim = lib.mkMerge [
      {
        enable = true;
      }
      settings
    ];

    environment.shellAliases = {
      vim = "nvim";
      V = "nvim";
    };
  };
}
