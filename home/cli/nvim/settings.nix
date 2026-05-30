{
  clipboard = {
    enable = true;
    registers = "unnamedplus";
    providers.wl-copy.enable = true;
  };

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
