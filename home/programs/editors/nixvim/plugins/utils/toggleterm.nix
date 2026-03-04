let
  utils = import ../../_utils.nix;
  mkKeymapd = utils.mkKeymapd;
in {
  plugins.toggleterm.enable = true;
  plugins.toggleterm.settings = {
    size = ''
      function(term)
        if term.direction == "horizontal" then
          return 8
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end
    '';
    shell = "zsh";
    open_mapping = "[[<C-\\>]]";
    persist_size = true;
    direction = "float";
    term_width = 120;
    term_high = 20;
    float_opts = {
      border = "rounded";
      winblend = 0;
      height = 20;
      width = 80;
    };
    winbar.enabled = true;
  };

  plugins.which-key.settings.spec = [{
    __unkeyed-1 = "<leader>r";
    group = "[R]un";
    icon = "󰴉";
    mode = "n";
  }];

  extraConfigLua = ''
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
