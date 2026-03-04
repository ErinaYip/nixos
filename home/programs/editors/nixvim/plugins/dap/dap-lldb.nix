{ pkgs, ... }: {
  plugins.dap-lldb.enable = true;
  plugins.dap-lldb.settings = {
    codelldb_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
  };

  extraPackages = [
    pkgs.vscode-extensions.vadimcn.vscode-lldb
  ];

  extraConfigLua = ''
    local dap = require("dap")
    local cpp_cfg = {
      name = "Launch current file",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.expand("%:p:r")
      end,
      cwd = "''${workspaceFolder}",
      stopOnEntry = false,
      args = {},
    }
    dap.configurations.cpp = { cpp_cfg }
    dap.configurations.c = { cpp_cfg }
  '';
}
