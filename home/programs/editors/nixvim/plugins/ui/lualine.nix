{
  plugins.lualine.enable = true;
  plugins.lualine.settings.options = {
    always_show_tabline = true;
    globalstatus = true;
    disabled_filetypes = {
      statusline = [ "snacks_dashboard" ];
      winbar = [ ];
    };
    ignore_focus = [ "neo-tree" "snacks_picker" "snacks_picker_list" "snacks_picker_input"  ];
    theme = "auto";
    component_separators = {
      left = "";
      right = "";
    };
    section_separators =  {
      left = "";
      right = "";
    };
  };
  plugins.lualine.settings.sections = {
    lualine_a = [ { __unkeyed-1 = "mode"; separator.left = ""; } ];
    lualine_b = [ "branch" "diff" ];
    lualine_c = [ "diagnostics" ];
    lualine_x = [
      {
        __raw = ''{
          function() return require("noice").api.status.mode.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
        }'';
      }
    ];
    lualine_y = [ "filetype" "encoding" ];
    lualine_z = [ { __unkeyed-1 = "location"; separator.right = ""; } ];
  };
}
