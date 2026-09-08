{
  statusline.lualine = {
    enable = true;

    integrations.breadcrumbs = {
      nvim-navic.enable = true;
      navbuddy.enable = true;
    };

    setupOpts = {
      options = {
        disabled_filetypes = {
          statusline = ["snacks_dashboard"];
          winbar = [];
        };
        ignore_focus = ["neo-tree" "snacks_picker" "snacks_picker_list" "snacks_picker_input"];

        component_separators = {
          left = "";
          right = "";
        };
        section_separators = {
          left = "";
          right = "";
        };
        globalstatus = true;
      };

      sections = {
        lualine_a = [
          {
            "@1" = "mode";
            separator.left = "";
          }
        ];
        lualine_b = [
          {"@1" = "branch";}
          {"@1" = "diff";}
        ];
        lualine_c = [
          {
            "@1" = "diagnostics";
            sources = ["nvim_lsp" "nvim_diagnostic" "vim_lsp" "coc"];
            symbols = {
              error = "󰅙  ";
              warn = "  ";
              info = "  ";
              hint = "󰌵 ";
            };
            colored = true;
            update_in_insert = false;
            always_visible = false;
            diagnostics_color = {
              color_error.fg = "red";
              color_warn.fg = "yellow";
              color_info.fg = "cyan";
            };
          }
        ];
        lualine_x = [
          {
            _type = "lua-inline";
            expr = ''require("snacks").profiler.status()'';
          }
          {
            _type = "lua-inline";
            expr = ''
              {
                function() return require("noice").api.status.command.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                color = function() return { fg = require("snacks").util.color("Statement") } end,
              }
            '';
          }
          {
            _type = "lua-inline";
            expr = ''
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
                icon = " ",
              }
            '';
          }
        ];
        lualine_y = ["filetype" "encoding"];
        lualine_z = [
          {
            "@1" = "location";
            separator.right = "";
          }
        ];
      };
    };
  };
}
