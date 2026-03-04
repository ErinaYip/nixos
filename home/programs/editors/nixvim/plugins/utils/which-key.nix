{
  plugins.which-key.enable = true;
  plugins.which-key.settings = {
    preset = "helix";
    delay = 100;
    spec = [
      {
        __unkeyed-1 = "<leader>g";
        group = "[G]it";
        icon = "";
        mode = "n";
      }
      {
        __unkeyed-1 = "<leader>t";
        group = "[T]erminal";
        icon = "";
        mode = "n";
      }
      {
        __unkeyed-1 = "<leader>b";
        group = "[B]uffer";
        icon = "";
        mode = "n";
      }
      {
        __unkeyed-1 = "<leader>bg";
        group = "[B]uffer [G]oto";
        icon = "";
        mode = "n";
      }
      {
        __unkeyed-1 = "<leader>q";
        group = "[Q]uit";
        icon = "󰩈";
        mode = "n";
      }
    ];
  };
  keymaps = [
    # {
    #   mode = [ "n" ];
    #   key = "<C-/>";
    #   action = "<cmd>lua require('which-key').show({ global = true })<cr>";
    #   options = {
    #     silent = true;
    #     noremap = true;
    #   };
    # }
  ];
}
