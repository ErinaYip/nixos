{
  mkKeymapd,
  mkKeymaps,
  ...
}: {
  keymaps = [
    (mkKeymaps ["n" "x"] "d" ''"_d'')
    (mkKeymaps ["n" "x"] "c" ''"_c'')

    (mkKeymaps ["n"] "<Up>" "<Nop>")
    (mkKeymaps ["n"] "<Down>" "<Nop>")
    (mkKeymaps ["n"] "<Right>" "<Nop>")
    (mkKeymaps ["n"] "<Left>" "<Nop>")

    (mkKeymaps ["n"] "<C-h>" "<C-w>h")
    (mkKeymaps ["n"] "<C-j>" "<C-w>j")
    (mkKeymaps ["n"] "<C-k>" "<C-w>k")
    (mkKeymaps ["n"] "<C-l>" "<C-w>l")

    (mkKeymaps ["n"] "<esc>" "<cmd>noh<cr>")

    (mkKeymaps ["n"] "<A-j>" "<cmd>m .+1<CR>==")
    (mkKeymaps ["n"] "<A-k>" "<cmd>m .-2<CR>==")

    (mkKeymapd ["n"] "<leader>qs" "<cmd>wqa<cr>" "[Q]uit and [S]ave")
    (mkKeymapd ["n"] "<leader>qq" "<cmd>qa<cr>" "[Q]uit without [S]ave")
  ];
}
