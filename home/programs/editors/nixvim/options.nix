{
  clipboard = {
    register = "unnamedplus";
    providers.wl-copy.enable = true;
  };

  opts = {
    number = true;
    relativenumber = true;
    cursorline = true;
    autowrite = true;
    # splitbelow = true;
    splitright = true;
    winborder = "rounded";
    signcolumn = "yes";
    fileformat = "unix";
    fileformats = ["unix" "dos" "mac"];
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
    sidescrolloff = 5;
    undofile = true;
    clipboard = "unnamedplus";
    virtualedit = "block";
  };
}
