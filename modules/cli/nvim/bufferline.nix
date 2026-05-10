{mkKeymapd, ...}: {
  tabline.nvimBufferline = {
    enable = true;
    setupOpts.options = {
      indicator = {
        style = "icon";
        icon = "▎";
      };
    };
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
