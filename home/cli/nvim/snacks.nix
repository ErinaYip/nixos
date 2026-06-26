{mkKeymapd, ...}: {
  utility.snacks-nvim = {
    enable = true;
    setupOpts = {
      explorer = {
        enable = true;
        auto_close = true;
      };

      bigfile.enabled = true;

      dashboard = {
        sections = [
          {section = "header";}
          {
            icon = "";
            title = "";
            section = "keys";
            indent = 2;
            padding = 1;
          }
        ];
        preset = {
          keys = [
            {
              icon = "󰈞 ";
              key = "f";
              desc = "Find files";
              action = ":lua Snacks.picker.smart()";
            }
            {
              icon = " ";
              key = "h";
              desc = "Find history";
              action = "lua Snacks.picker.recent()";
            }
            {
              icon = " ";
              key = "e";
              desc = "New file";
              action = ":enew";
            }
            {
              icon = " ";
              key = "o";
              desc = "Recent files";
              action = ":lua Snacks.picker.recent()";
            }
            {
              icon = " ";
              key = "q";
              desc = "Quit";
              action = ":qa";
            }
          ];
          header = ''
            ██████████            ███                         ${""}
            ▒▒███▒▒▒▒▒█           ▒▒▒                         ${""}
              ▒███  █ ▒  ████████  ████  ████████    ██████   ${""}
              ▒██████   ▒▒███▒▒███▒▒███ ▒▒███▒▒███  ▒▒▒▒▒███  ${""}
              ▒███▒▒█    ▒███ ▒▒▒  ▒███  ▒███ ▒███   ███████  ${""}
              ▒███ ▒   █ ▒███      ▒███  ▒███ ▒███  ███▒▒███  ${""}
              ██████████ █████     █████ ████ █████▒▒████████ ${""}
            ▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒     ▒▒▒▒▒ ▒▒▒▒ ▒▒▒▒▒  ▒▒▒▒▒▒▒▒   ${""}
          '';
        };
      };
    };
  };

  luaConfigPost = ''
    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
  '';

  keymaps = [
    (mkKeymapd ["n"] "<leader>e" "<cmd>lua Snacks.explorer()<cr>" "[E]xplorer")
    (mkKeymapd ["n"] "<leader>fw" ":lua Snacks.picker.grep()<cr>" "[F]ind content (snacks)")
    (mkKeymapd ["n"] "<leader>ff" ":lua Snacks.picker.smart()<cr>" "[F]ind file smartly (snacks)")
    (mkKeymapd ["n"] "<leader> " ":lua Snacks.picker.smart()<cr>" "[F]ind file smartly (snacks)")
    (mkKeymapd ["n"] "<leader>fo" ":lua Snacks.picker.recent()<cr>" "[F]ind in recent file (snacks)")
    (mkKeymapd ["n"] "<leader>fh" ":lua Snacks.picker.help()<cr>" "[F]ind in [H]elp (snacks)")
  ];
}
