let
  utils = import ../../_utils.nix;
  mkKeymapd = utils.mkKeymapd;
in {
  plugins.bufferline = {
    enable = true;
    lazyLoad.settings = {
      event = "BufLeave";
      # cmd = "Neotree";
    };
  };
  plugins.bufferline.settings.options = {
    indicator = {
      style = "icon";
      icon = "▎";
    };
    left_trunc_marker = "";
    max_name_length = 18;
    max_prefix_length = 15;
    modified_icon = "●";
    numbers.__raw = ''
      function(opts)
        return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
      end
    '';
    persist_buffer_sort = true;
    right_trunc_marker = "";
    show_buffer_close_icons = true;
    show_buffer_icons = true;
    show_close_icon = true;
    show_tab_indicators = true;
    tab_size = 18;
    offsets = [
      {
        filetype = "neo-tree";
        text = "File Explorer";
        text_align = "left";
        highlight = "Directory";
      }
    ];
  };
  keymaps = [
    (mkKeymapd ["n"] "<leader>bp" "<cmd>BufferLineTogglePin<cr>" "[B]uffer [P]in")
    (mkKeymapd ["n"] "<leader>bP" "<cmd>BufferLineGroupClose ungrouped<cr>" "[B]uffer delete non-pinned")
    (mkKeymapd ["n"] "<leader>br" "<cmd>BufferLineCloseRight<cr>" "[B]uffer close right")
    (mkKeymapd ["n"] "<leader>bl" "<cmd>BufferLineCloseLeft<cr>" "[B]uffer close left")
    (mkKeymapd ["n"] "<S-h>" "<cmd>BufferLineCyclePrev<cr>" "Prev Buffer")
    (mkKeymapd ["n"] "<S-l>" "<cmd>BufferLineCycleNext<cr>" "Next Buffer")
    (mkKeymapd ["n"] "[b" "<cmd>BufferLineCyclePrev<cr>" "Prev Buffer")
    (mkKeymapd ["n"] "]b" "<cmd>BufferLineCycleNext<cr>" "Next Buffer")
    (mkKeymapd ["n"] "[B" "<cmd>BufferLineMovePrev<cr>" "Move buffer prev")
    (mkKeymapd ["n"] "]B" "<cmd>BufferLineMoveNext<cr>" "Move buffer next")
  ];
}
