let
  utils = import ../../_utils.nix;
  mkKeymapd = utils.mkKeymapd;
in {
  plugins.snacks.settings.explorer = {
    enabled = true;
  };

  plugins.which-key.settings.spec = [{
    __unkeyed-1 = "<leader>e";
    group = "[E]xplorer";
    icon = "󰉋";
    mode = "n";
  }];

  keymaps = [
    (mkKeymapd ["n"] "<leader>e" "<cmd>lua Snacks.explorer()<cr>" "[E]xplorer")
  ];
}
