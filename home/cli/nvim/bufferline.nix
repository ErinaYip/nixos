{
  mkKeymaps,
  mkKeymapd,
  ...
}: {
  tabline.nvimBufferline = {
    enable = true;
    setupOpts.options = {
      numbers = "ordinal";
      indicator = {
        style = "icon";
      };
      separator_style = "slant";
      hover.delay = 10;
    };
  };

  keymaps =
    [
      # (mkKeymapd ["n"] "<leader>bp" "<cmd>BufferLineTogglePin<cr>" "[B]uffer [P]in")
      # (mkKeymapd ["n"] "<leader>bP" "<cmd>BufferLineGroupClose ungrouped<cr>" "[B]uffer delete non-pinned")
      (mkKeymapd ["n"] "<leader>bd" "<cmd>bd<cr>" "[B]uffer [D]elete")
      (mkKeymapd ["n"] "<leader>br" "<cmd>BufferLineCloseRight<cr>" "[B]uffer close [R]ight")
      (mkKeymapd ["n"] "<leader>bl" "<cmd>BufferLineCloseLeft<cr>" "[B]uffer close [L]eft")
      (mkKeymapd ["n"] "<leader>bo" "<cmd>BufferLineCloseOthers<cr>" "[B]uffer close [O]thers")
      (mkKeymapd ["n"] "<S-h>" "<cmd>BufferLineCyclePrev<cr>" "Prev Buffer")
      (mkKeymapd ["n"] "<S-l>" "<cmd>BufferLineCycleNext<cr>" "Next Buffer")
      (mkKeymapd ["n"] "[b" "<cmd>BufferLineCyclePrev<cr>" "Prev Buffer")
      (mkKeymapd ["n"] "]b" "<cmd>BufferLineCycleNext<cr>" "Next Buffer")
      (mkKeymapd ["n"] "[B" "<cmd>BufferLineMovePrev<cr>" "Move buffer prev")
      (mkKeymapd ["n"] "]B" "<cmd>BufferLineMoveNext<cr>" "Move buffer next")
    ]
    ++ (
      builtins.concatLists (builtins.genList (
          i: let
            buffer = toString (i + 1);
          in [
            (mkKeymaps ["n"] "<leader>${buffer}" "<cmd>BufferLineGoToBuffer ${buffer}<cr>")
            (mkKeymaps ["n"] "<leader>b${buffer}" "<cmd>bd ${buffer}<cr>")
          ]
        )
        9)
    );
}
