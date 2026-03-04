{
  plugins.gitsigns = {
    enable = true;
    lazyLoad.settings.event = [ "BufEnter" ];
  };
  plugins.gitsigns.settings = {
    signs = {
      add.text          = "│";
      change.text       = "│";
      changedelete.text = "~";
      delete.text       = "";
      topdelete.text    = "";
      untracked.text    = "┆";
    };
  };
}
