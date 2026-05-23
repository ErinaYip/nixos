{mkKeymapd, ...}: {
  terminal.toggleterm = {
    enable = true;
    setupOpts = {
      shell = "zsh";
      direction = "float";
    };
    lazygit.enable = true;
  };

  luaConfigPost = ''
    function _G.RunCode()
      local file = vim.fn.expand("%:p")
      local ext = vim.fn.expand("%:e")
      local cmd = ""

      if ext == "py" then
        cmd = string.format("python3 %s", vim.fn.shellescape(file))
      elseif ext == "cpp" or ext == "cc" or ext == "cxx" then
        local out = vim.fn.expand("%:p:r")
        cmd = string.format(
          "g++ -std=c++20 -O0 -g -Wall -Wextra %s -o %s && %s",
          vim.fn.shellescape(file),
          vim.fn.shellescape(out),
          vim.fn.shellescape(out)
        )
      else
        print("Unsupported file type: " .. ext)
        return
      end

      vim.cmd("w")
      require("toggleterm").exec(cmd, 1, 12)
    end
  '';

  keymaps = [
    (mkKeymapd ["n"] "<leader>tt" "<cmd>ToggleTerm<cr>" "[T]erminal [T]oggle")
    (mkKeymapd ["n"] "<leader>tv" "<cmd>ToggleTerm direction=vertical<cr>" "[T]erminal [V]ertical")
    (mkKeymapd ["n"] "<leader>th" "<cmd>ToggleTerm direction=horizontal<cr>" "[T]erminal [H]orizontal")
    (mkKeymapd ["n"] "<leader>tf" "<cmd>ToggleTerm direction=float<cr>" "[T]erminal [F]loat")
    (mkKeymapd ["t"] "<esc>" "<C-\\><C-n>" "Terminal Normal Mode")

    (mkKeymapd ["n"] "<leader>rr" "<cmd>lua RunCode()<cr>" "[R]un [R]un Code")
  ];
}
