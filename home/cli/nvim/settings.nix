{
  clipboard = {
    enable = true;
    registers = "unnamedplus";
    providers.wl-copy.enable = true;
  };

  luaConfigRC.fcitx5 = ''
    local fcitx5_restore = false
    local fcitx5_available = vim.fn.executable("fcitx5-remote") == 1

    local function fcitx5_remote(arg)
      if not fcitx5_available then
        return nil
      end

      local cmd = { "fcitx5-remote" }
      if arg ~= nil then
        table.insert(cmd, arg)
      end

      local output = vim.fn.system(cmd)
      if vim.v.shell_error == 0 then
        return vim.trim(output)
      end

      return nil
    end

    local function fcitx5_close(remember)
      local state = fcitx5_remote()
      if remember then
        fcitx5_restore = state == "2"
      end

      if state ~= nil then
        fcitx5_remote("-c")
      end
    end

    local function fcitx5_restore_input()
      if fcitx5_restore then
        fcitx5_remote("-o")
      end
    end

    local fcitx5_group = vim.api.nvim_create_augroup("Fcitx5ModeSwitch", { clear = true })

    vim.api.nvim_create_autocmd({ "VimEnter", "InsertLeave" }, {
      group = fcitx5_group,
      callback = function()
        fcitx5_close(true)
      end,
    })

    vim.api.nvim_create_autocmd("CmdlineLeave", {
      group = fcitx5_group,
      callback = function()
        fcitx5_close(false)
      end,
    })

    vim.api.nvim_create_autocmd("InsertEnter", {
      group = fcitx5_group,
      callback = fcitx5_restore_input,
    })
  '';

  options = {
    number = true;
    relativenumber = true;
    cursorline = true;
    autowrite = true;
    splitbelow = true;
    splitright = true;
    winborder = "rounded";
    signcolumn = "yes";
    fileformat = "unix";
    # fileformats = ["unix" "dos" "mac"];
    wrap = false;
    ignorecase = true;
    smartcase = true;
    hlsearch = true;
    incsearch = true;
    tabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    autoindent = true;
    smartindent = true;
    termguicolors = true;
    laststatus = 2;
    scrolloff = 999;
    sidescrolloff = 999;
    undofile = true;
    clipboard = "unnamedplus";
    virtualedit = "block";
    list = true;
    listchars = "trail:·,tab:  ";

    foldmethod = "expr";
    foldlevel = 99;
    foldlevelstart = 99;
    foldenable = true;
  };

  # theme = {
  #   enable = true;
  #   style = "auto";
  #   name = "catppuccin";
  # };
}
