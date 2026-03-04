{ ... }: {
  plugins.snacks.settings.notifier.enable = true;

  plugins.which-key.settings.spec = [{
    __unkeyed-1 = "<leader>n";
    group = "[N]otifier";
    icon = "";
    mode = "n";
  }];

  keymaps = [
    {
      mode = ["n"];
      key = "<leader>ns";
      action = "<cmd>lua Snacks.notifier.show_history()<cr>";
      options = {
        silent = true;
        desc = "[N]otifyer [S]how History";
      };
    }
  ];
}