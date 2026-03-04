{
  plugins.lazygit = {
    enable = true;
    lazyLoad.settings.cmd = "LazyGit";
  };
  keymaps = [
    {
      action = "<cmd>LazyGit<cr>";
      key = "<leader>gg";
      options = {
        silent = true;
        desc = "[G]it LazyGit";
      };
    }
  ];
}