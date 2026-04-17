{
  lib,
  inputs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "cli";
  name = "nvim";

  defaultSettings = {
    plugins = {
      dap.enable = false;
      dap-ui.enable = false;
      dap-lldb.enable = false;
      dap-virtual-text.enable = false;
    };
  };

  configFn = { settings, ... }: {
    home-manager.sharedModules = [ inputs.erina-vim.homeModules.default ];

    erinite.home.programs.erina-vim = {
      enable = true;
    } // settings;

    environment.shellAliases = {
      vim = "nvim";
      V = "nvim";
    };
  };
}
