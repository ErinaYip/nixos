{
  plugins.flash = {
    enable = true;
    lazyLoad.settings = {
      event = [ "BufEnter" ];
    };
  };
  keymaps = [
    {
      mode = [ "n" "x" "o" ];
      key = "s";
      action = "<cmd>lua require('flash').jump()<cr>";
      options = {
        silent = true;
        noremap = true;
        desc = "Flash";
      };
    }
    {
      mode = [ "n" "o" "x" ];
      key = "S";
      action = "<cmd>lua require('flash').treesitter()<cr>";
      options = {
        silent = true;
        noremap = true;
        desc = "Flash Treesitter";
      };
    }
  ];
}
