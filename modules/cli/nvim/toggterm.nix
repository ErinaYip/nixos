{ lib, mkKeymapd, ... }: {
  terminal = {
    toggleterm = {
      enable = true;
      setupOpts = {
        shell = "zsh";
        direction = "float";
        # size = lib.mkLuaInline ''
        #   function(term)
        #     if term.direction == "horizontal" then
        #       return 8
        #     elseif term.direction == "vertical" then
        #       return vim.o.columns * 0.4
        #     end
        #   end
        # '';
      };
      lazygit.enable = true;
    };
  };
  
  keymaps = [
    (mkKeymapd ["n"] "<leader>tt" "<cmd>ToggleTerm<cr>" "[T]erminal [T]oggle")
    (mkKeymapd ["n"] "<leader>tv" "<cmd>ToggleTerm direction=vertical<cr>" "[T]erminal [V]ertical")
    (mkKeymapd ["n"] "<leader>th" "<cmd>ToggleTerm direction=horizontal<cr>" "[T]erminal [H]orizontal")
    (mkKeymapd ["n"] "<leader>tf" "<cmd>ToggleTerm direction=float<cr>" "[T]erminal [F]loat")
    (mkKeymapd ["t"] "<esc>" "<C-\\><C-n>" "Terminal Normal Mode")

    (mkKeymapd ["n"] "<leader>rr" "<cmd>lua RunCode()<cr>" "[R]un [R]un Code")
  ];
}
