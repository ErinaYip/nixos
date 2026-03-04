{ pkgs, lib, ... }:
let
  utils = import ../../_utils.nix;
  mkKeymapd = utils.mkKeymapd;
in {
  imports = [
    ./dap-ui.nix
    ./dap-lldb.nix
  ];

  plugins.dap = {
    enable = true;
  };

  plugins.dap.signs = {
    dapBreakpoint = { text = "🔴"; };
    dapBreakpointCondition = { text = "🟡"; };
    dapLogPoint = { text = "◉"; };
    dapStopped = { text = "▶"; };
  };

  plugins.which-key.settings.spec = [{
    __unkeyed-1 = "<leader>d";
    group = "[D]ebug";
    icon = "";
    mode = "n";
  }];
  keymaps = [
    (mkKeymapd ["n"] "<leader>db" "<cmd>lua require('dap').toggle_breakpoint()<cr>" "[D]ebug [B]reakpoint")
    (mkKeymapd ["n"] "<leader>dB" "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>" "[D]ebug Conditional [B]reakpoint")
    (mkKeymapd ["n"] "<leader>dd" "<cmd>lua require('dap').clear_breakpoints()<cr>" "[D]ebug [D]elete all breakpoints")
    (mkKeymapd ["n"] "<leader>dc" "<cmd>lua require('dap').continue()<cr>" "[D]ebug [C]ontinue")
    (mkKeymapd ["n"] "<leader>dx" "<cmd>lua require('dap').terminate()<cr>" "[D]ebug E[x]it")
    (mkKeymapd ["n"] "<leader>dn" "<cmd>lua require('dap').step_over()<cr>" "[D]ebug step [N]ext")
    (mkKeymapd ["n"] "<leader>di" "<cmd>lua require('dap').step_into()<cr>" "[D]ebug step [I]nto")
    (mkKeymapd ["n"] "<leader>do" "<cmd>lua require('dap').step_out()<cr>" "[D]ebug step [O]ut")
    (mkKeymapd ["n"] "<leader>d[" "<cmd>lua require('dap').up()<cr>" "[D]ebug [U]p stack")
    (mkKeymapd ["n"] "<leader>d]" "<cmd>lua require('dap').down()<cr>" "[D]ebug [D]own stack")
    (mkKeymapd ["n"] "<leader>dl" "<cmd>lua require('dap').run_last()<cr>" "[D]ebug [L]ast run")
    (mkKeymapd ["n"] "<leader>dC" "<cmd>lua require('dap').run_to_cursor()<cr>" "[D]ebug run to [C]ursor")
    (mkKeymapd ["n"] "<leader>dr" "<cmd>lua require('dap').repl.toggle()<cr>" "[D]ebug [R]EPL")
    (mkKeymapd ["n"] "<leader>dw" "<cmd>lua require('dap.ui.widgets').hover()<cr>" "[D]ebug [W]atch")
    (mkKeymapd ["n"] "<F5>" "<cmd>lua require('dap').continue()<cr>" "[D]ebug [C]ontinue(F5)")
    (mkKeymapd ["n"] "<F10>" "<cmd>lua require('dap').step_over()<cr>" "[D]ebug step [N]ext(F10)")
    (mkKeymapd ["n"] "<F11>" "<cmd>lua require('dap').step_into()<cr>" "[D]ebug step [I]nto(F11)")
    (mkKeymapd ["n"] "<F12>" "<cmd>lua require('dap').step_out()<cr>" "[D]ebug step [O]ut(F12)")
  ];
}
