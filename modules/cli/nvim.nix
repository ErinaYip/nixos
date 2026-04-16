{
  lib,
  inputs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "cli";
  name = "bat";

  configFn = { settings, ... }: {
    home-manager.sharedmodules = [ inputs.erina-vim.homeModules.default ];

    erinite.home.programs.erina-vim = {
      enable = true;
      plugins = {
        dap.enable = false;
        dap-ui.enable = false;
        dap-lldb.enable = false;
        dap-virtual-text.enable = false;
      };
    } // settings;

    environment.shellAliases = {
      vim = "nvim";
      V = "nvim";
    };
  };
}
