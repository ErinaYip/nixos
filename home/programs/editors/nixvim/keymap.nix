let
  utils = import ./_utils.nix;
  mkKeymapd = utils.mkKeymapd;
  mkKeymap = utils.mkKeymapSimple;
in {
  globals.mapleader = " ";
  keymaps = [
    (mkKeymap ["n"] "<Up>" "<Nop>")
    (mkKeymap ["n"] "<Down>" "<Nop>")
    (mkKeymap ["n"] "<Right>" "<Nop>")
    (mkKeymap ["n"] "<Left>" "<Nop>")

    (mkKeymap ["n"] "<C-h>" "<C-w>h")
    (mkKeymap ["n"] "<C-j>" "<C-w>j")
    (mkKeymap ["n"] "<C-k>" "<C-w>k")
    (mkKeymap ["n"] "<C-l>" "<C-w>l")

    (mkKeymap ["n"] "<esc>" "<cmd>noh<cr>")

    (mkKeymap ["n"] "<A-j>" "<cmd>m .+1<CR>==" )
    (mkKeymap ["n"] "<A-k>" "<cmd>m .-2<CR>==" )

    (mkKeymapd ["n"] "<leader>qs" "<cmd>wqa<cr>" "[Q]uit and [S]ave")
    (mkKeymapd ["n"] "<leader>qq" "<cmd>qa<cr>" "[Q]uit without [S]ave")
  ];
}
