let
  utils = import ../../_utils.nix;
  mkKeymapd = utils.mkKeymapd;
in {
  plugins.barbar = {
    enable = true;
    lazyLoad.settings = {
      event = "BufLeave";
    };
  };
  plugins.barbar.settings = {
    exclude_ft = [
      "snacks_picker"
      "snacks_picker_list"
      "snacks_picker_input"
      "snacks_dashboard"
    ];
    icons = {
      buffer_index = true;
      buffer_number = false;
      preset = "default";
    };
    sidebar_filetypes = {
      neo-tree = { text = "Explorer"; align = "center"; };
      snacks_picker = { text = "Explorer";
      };
      snacks_layout_box = {
        text = "";
      };
    };
  };
  keymaps = [
    (mkKeymapd ["n"] "<leader>bn" "<cmd>BufferNext<cr>" "[B]uffer [N]ext")
    (mkKeymapd ["n"] "<leader>bp" "<cmd>BufferPrevious<cr>" "[B]uffer [P]revious")
    (mkKeymapd ["n"] "<leader>bb" "<cmd>BufferPick<cr>" "[B]uffer [B]uffer Pick")
    (mkKeymapd ["n"] "<leader>bP" "<cmd>BufferPin<cr>" "[B]uffer [P]in")

    (mkKeymapd ["n"] "<leader>bg1" "<cmd>BufferGoto 1<cr>" "[B]uffer [G]oto 1")
    (mkKeymapd ["n"] "<leader>bg2" "<cmd>BufferGoto 2<cr>" "[B]uffer [G]oto 2")
    (mkKeymapd ["n"] "<leader>bg3" "<cmd>BufferGoto 3<cr>" "[B]uffer [G]oto 3")
    (mkKeymapd ["n"] "<leader>bg4" "<cmd>BufferGoto 4<cr>" "[B]uffer [G]oto 4")
    (mkKeymapd ["n"] "<leader>bg5" "<cmd>BufferGoto 5<cr>" "[B]uffer [G]oto 5")

    (mkKeymapd ["n"] "<S-h>" "<cmd>BufferPrevious<cr>" "Prev Buffer")
    (mkKeymapd ["n"] "<S-l>" "<cmd>BufferNext<cr>" "Next Buffer")
    (mkKeymapd ["n"] "[b" "<cmd>BufferPrevious<cr>" "Prev Buffer")
    (mkKeymapd ["n"] "]b" "<cmd>BufferNext<cr>" "Next Buffer")
  ];
}
