{
  plugins.dap-ui = {
    enable = true;
  };

  plugins.dap-virtual-text = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        keys = [
          {
            __unkeyed-1 = "<leader>dB";
            __unkeyed-3.__raw = ''
              function()
                require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: '))
              end
            '';
            desc = "[D]ebug Conditional [B]reakpoint";
          }
          {
            __unkeyed-1 = "<leader>db";
            __unkeyed-3.__raw = ''
              function()
                require("dap").toggle_breakpoint()
              end
            '';
            desc = "[D]ebug [B]reakpoint";
          }
        ];
      };
    };
    settings = {
      enabled = true;
      highlight_changed_variables = true;
      show_stop_reason = true;
      virt_text_pos = "eol";
    };
  };

  extraConfigLua = ''
    local dap = require("dap")
    require("dapui").setup({
      layouts = {
        {
          position = "left",
          size = 0.25,
          elements = {
            { id = "watches", size = 0.2 },
            { id = "stacks", size = 0.35 },
            { id = "breakpoints", size = 0.1 },
            { id = "scopes", size = 0.35 },
          },
        },
        {
          position = "bottom",
          size = 0.3,
          elements = {
            { id = "console", size = 0.5 },
            { id = "repl", size = 0.5 },
          },
        },
      },
    })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      require("dapui").open({ reset = true })
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      require("dapui").close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      require("dapui").close()
    end
  '';
}
