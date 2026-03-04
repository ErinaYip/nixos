let
  utils = import ../../_utils.nix;
  mkKeymapd = utils.mkKeymapd;
in
{
  plugins.snacks.settings.picker = {
    enabled = true;
  };

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>f";
      group = "[F]ind";
      icon = "󰈞";
      mode = "n";
    }
    {
      __unkeyed-1 = "<leader> ";
      group = "Find file";
      icon = "󰈞";
      mode = "n";
    }
  ];

  keymaps = [
    (mkKeymapd ["n"] "<leader>fw" ":lua Snacks.picker.grep()<cr>" "[F]ind content (snacks)")
    (mkKeymapd ["n"] "<leader>ff" ":lua Snacks.picker.smart()<cr>" "[F]ind file smartly (snacks)")
    (mkKeymapd ["n"] "<leader> " ":lua Snacks.picker.smart()<cr>" "[F]ind file smartly (snacks)")
    (mkKeymapd ["n"] "<leader>fo" ":lua Snacks.picker.recent()<cr>" "[F]ind in recent file (snacks)")
    (mkKeymapd ["n"] "<leader>fh" ":lua Snacks.picker.help()<cr>" "[F]ind in [H]elp (snacks)")
  ];
}
