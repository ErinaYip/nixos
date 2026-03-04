let
  utils = import ../../_utils.nix;
  mkKeymapd = utils.mkKeymapd;
in {
  plugins.snacks.enable = true;
  plugins.snacks.settings = {
    bigfile.enable = true;
    quickfile.enable = true;
    indent.enable = true;
  };
  imports = [
    ./explorer.nix
    ./dashboard.nix
    ./notifier.nix
    ./toggle.nix
    ./picker.nix
  ];

  keymaps = [
    (mkKeymapd ["n"] "<leader>bd" "<cmd>lua Snacks.bufdelete()<cr>" "[B]uffer [D]elete (snacks)")
    (mkKeymapd ["n"] "<leader>ba" "<cmd>lua Snacks.bufdelete.all()<cr>" "[B]uffer [D]elete [A]ll (snacks)")
    (mkKeymapd ["n"] "<leader>bo" "<cmd>lua Snacks.bufdelete.other()<cr>" "[B]uffer [D]elete [O]ther (snacks)")
    (mkKeymapd ["n"] "<leader>qb" "<cmd>lua Snacks.bufdelete()<cr>" "[Q]uit [B]uffer (snacks)")
  ];
}
