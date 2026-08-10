{
  statusline.lualine = {
    enable = true;
    # theme = "auto";

    setupOpts.options = {
      disabled_filetypes = {
        statusline = ["snacks_dashboard"];
        winbar = [];
      };
      ignore_focus = ["neo-tree" "snacks_picker" "snacks_picker_list" "snacks_picker_input"];
    };

    globalStatus = true;
    componentSeparator = {
      left = "";
      right = "";
    };
    sectionSeparator = {
      left = "";
      right = "";
    };

    activeSection = {
      a = [
        ''
          {
            "mode",
            separator = {left = "" }
          }
        ''
      ];
      b = [
        ''
          {"branch"}
        ''
        ''
          {"diff"}
        ''
      ];
      c = [
        ''
          {
            "diagnostics",
            sources = {'nvim_lsp', 'nvim_diagnostic', 'nvim_diagnostic', 'vim_lsp', 'coc'},
            symbols = {error = '󰅙  ', warn = '  ', info = '  ', hint = '󰌵 '},
            colored = true,
            update_in_insert = false,
            always_visible = false,
            diagnostics_color = {
              color_error = { fg = 'red' },
              color_warn = { fg = 'yellow' },
              color_info = { fg = 'cyan' },
            },
          }
        ''
      ];
      x = [
        ''require("snacks").profiler.status()''
        ''
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = function() return { fg = require("snacks").util.color("Statement") } end,
          }
        ''
        # ''
        #   {
        #     function() return require("noice").api.status.mode.get() end,
        #     cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
        #     color = function() return { fg = require("snacks").util.color("Constant") } end,
        #   }
        # ''
        ''
          {
            -- Lsp server name
            function()
              local buf_ft = vim.bo.filetype
              local excluded_buf_ft = { toggleterm = true, NvimTree = true, ["neo-tree"] = true, TelescopePrompt = true }

              if excluded_buf_ft[buf_ft] then
                return ""
                end

              local bufnr = vim.api.nvim_get_current_buf()
              local clients = vim.lsp.get_clients({ bufnr = bufnr })

              if vim.tbl_isempty(clients) then
                return "No Active LSP"
              end

              local active_clients = {}
              for _, client in ipairs(clients) do
                table.insert(active_clients, client.name)
              end

              return table.concat(active_clients, ", ")
            end,
            icon = ' ',
          }
        ''
      ];
      y = [
        ''
          {"filetype"}
        ''
        ''
          {"encoding"}
        ''
      ];
      z = [
        ''
          {
            "location",
            separator = { right = "" }
          }
        ''
      ];
    };
  };
}
