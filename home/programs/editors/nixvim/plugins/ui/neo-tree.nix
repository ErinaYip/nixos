{ lib, config,  ... }: {
  plugins.neo-tree = {
    enable = true;
    lazyLoad.settings.cmd = "Neotree";
  };
  plugins.neo-tree.settings = {
    window = {
      width = 30;
      mappings = {
        "<space>" = "none";
      };
    };
    filesystem = {
      bind_to_cwd = true;
      follow_current_file = {
        enabled = true;
        leave_dirs_open = true;
      };
      group_empty_dirs = true;
      hijack_netrw = true;
    };

    default_component_configs = {
      indent = {
        with_expanders = true;
        expander_collapsed = "󰅂";
        expander_expanded = "󰅀";
        expander_highlight = "NeoTreeExpander";
      };

      git_status = {
        symbols = {
          added = " ";
          modified = " ";
          deleted = "󰛌 ";
          renamed = "󰑕 ";
          untracked = " ";
          unstaged = " ";
          staged = "󰩍 ";
          ignored = " ";
          conflict = "";
        };
      };
    };
  };

  plugins.which-key.settings.spec = [{
    __unkeyed-1 = "<leader>e";
    group = "[E]xplorer";
    icon = "";
    mode = "n";
  }];

  keymaps = [
    {
      mode = ["n"];
      key = "<leader>e";
      action = "<cmd>Neotree toggle reveal_force_cwd<cr>";
      options = {
        silent = true;
      };
    }
  ];
}
