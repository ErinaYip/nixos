{
  lib,
  inputs,
  eriniteLib,
  ...
} @ args:

with eriniteLib; mkModule args {
  category = "cli";
  name = "nvim";

  imports = [ inputs.nvf.nixosModules.default ];

  configFn = { ... }: let
    mkKeymap = mode: key: action: desc: { silent ? true, noremap ? true }: {
      inherit mode key action silent noremap desc;
    };
    mkKeymapd = mode: key: action: desc: mkKeymap mode key action desc {};
    mkKeymaps = mode: key: action: mkKeymap mode key action "" {};
    inherit (lib.generators) mkLuaInline;
  in {
    programs.nvf = {
      enable = true;
      settings.vim = {
        viAlias = false;
        vimAlias = true;

        lazy = {
          enable = true;
        };

        clipboard = {
          enable = true;
          registers = "unnamedplus";
          providers.wl-copy.enable = true;
        };

        opts = {
          number = true;
          relativenumber = true;
          cursorline = true;
          autowrite = true;
          splitbelow = true;
          splitright = true;
          winborder = "rounded";
          signcolumn = "yes";
          fileformat = "unix";
          # fileformats = ["unix" "dos" "mac"];
          wrap = false;
          ignorecase = true;
          smartcase = true;
          hlsearch = true;
          incsearch = true;
          tabstop = 2;
          shiftwidth = 2;
          expandtab = true;
          autoindent = true;
          smartindent = true;
          termguicolors = true;
          laststatus = 2;
          scrolloff = 999;
          sidescrolloff = 5;
          undofile = true;
          clipboard = "unnamedplus";
          virtualedit = "block";
          # list = true;
          # listchars = "trail:·,tab:  ";
        };
        
        theme = {
          enable = true;
          style = "auto";
          name = "catppuccin";
        };

        statusline.lualine = {
          enable = true;
          theme = "auto";
        };

        ui.noice.enable = true;

        lsp = {
          enable = true;
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          markdown.enable = true;
        };


        visuals = {
          nvim-scrollbar.enable = true;
          nvim-web-devicons.enable = true;
          # nvim-cursorline.enable = true;
          # fidget-nvim.enable = true;

          # highlight-undo.enable = true;
          # blink-indent.enable = true;
          indent-blankline.enable = true;

        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete = {
          blink-cmp.enable = true;
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter.context.enable = true;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        git = {
          enable = true;
          gitsigns.enable = true;
        };

        notify = {
          nvim-notify.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            setupOpts = {
              shell = "zsh";
              direction = "float";
              size = mkLuaInline ''
                function(term)
                  if term.direction == "horizontal" then
                    return 8
                  elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                  end
                end
              '';
            };
            lazygit.enable = true;
          };
        };

        utility.snacks-nvim = {
          enable = true;
          setupOpts = {
            explorer.enable = true;
            dashboard = {
              sections = [
                { section = "header"; }
                { icon = ""; title = ""; section = "keys"; indent = 2; padding = 1; }
              ];
              preset = {
                keys = [
                  { icon = "󰈞 "; key = "f"; desc = "Find files"; action = ":lua Snacks.picker.smart()"; }
                  { icon = " "; key = "h"; desc = "Find history"; action = "lua Snacks.picker.recent()"; }
                  { icon = " "; key = "e"; desc = "New file"; action = ":enew"; }
                  { icon = " "; key = "o"; desc = "Recent files"; action = ":lua Snacks.picker.recent()"; }
                  { icon = " "; key = "q"; desc = "Quit"; action = ":qa"; }
                ];
                header = ''
                  ██████████            ███                      
                  ▒▒███▒▒▒▒▒█           ▒▒▒                       
                    ▒███  █ ▒  ████████  ████  ████████    ██████  
                    ▒██████   ▒▒███▒▒███▒▒███ ▒▒███▒▒███  ▒▒▒▒▒███ 
                    ▒███▒▒█    ▒███ ▒▒▒  ▒███  ▒███ ▒███   ███████ 
                    ▒███ ▒   █ ▒███      ▒███  ▒███ ▒███  ███▒▒███ 
                    ██████████ █████     █████ ████ █████▒▒████████
                  ▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒     ▒▒▒▒▒ ▒▒▒▒ ▒▒▒▒▒  ▒▒▒▒▒▒▒▒ 
                  '';
              };
            };
          };
        };

        keymaps = [
          (mkKeymaps ["n"] "<Up>" "<Nop>")
          (mkKeymaps ["n"] "<Down>" "<Nop>")
          (mkKeymaps ["n"] "<Right>" "<Nop>")
          (mkKeymaps ["n"] "<Left>" "<Nop>")

          (mkKeymaps ["n"] "<C-h>" "<C-w>h")
          (mkKeymaps ["n"] "<C-j>" "<C-w>j")
          (mkKeymaps ["n"] "<C-k>" "<C-w>k")
          (mkKeymaps ["n"] "<C-l>" "<C-w>l")

          (mkKeymaps ["n"] "<esc>" "<cmd>noh<cr>")

          (mkKeymaps ["n"] "<A-j>" "<cmd>m .+1<CR>==" )
          (mkKeymaps ["n"] "<A-k>" "<cmd>m .-2<CR>==" )

          (mkKeymapd ["n"] "<leader>qs" "<cmd>wqa<cr>" "[Q]uit and [S]ave")
          (mkKeymapd ["n"] "<leader>qq" "<cmd>qa<cr>" "[Q]uit without [S]ave")
          (mkKeymapd ["n"] "<leader>e" "<cmd>lua Snacks.explorer()<cr>" "[E]xplorer")
          (mkKeymapd ["n"] "<leader>fw" ":lua Snacks.picker.grep()<cr>" "[F]ind content (snacks)")
          (mkKeymapd ["n"] "<leader>ff" ":lua Snacks.picker.smart()<cr>" "[F]ind file smartly (snacks)")
          (mkKeymapd ["n"] "<leader> " ":lua Snacks.picker.smart()<cr>" "[F]ind file smartly (snacks)")
          (mkKeymapd ["n"] "<leader>fo" ":lua Snacks.picker.recent()<cr>" "[F]ind in recent file (snacks)")
          (mkKeymapd ["n"] "<leader>fh" ":lua Snacks.picker.help()<cr>" "[F]ind in [H]elp (snacks)")
          (mkKeymapd ["n"] "<leader>tt" "<cmd>ToggleTerm<cr>" "[T]erminal [T]oggle")
          (mkKeymapd ["n"] "<leader>tv" "<cmd>ToggleTerm direction=vertical<cr>" "[T]erminal [V]ertical")
          (mkKeymapd ["n"] "<leader>th" "<cmd>ToggleTerm direction=horizontal<cr>" "[T]erminal [H]orizontal")
          (mkKeymapd ["n"] "<leader>tf" "<cmd>ToggleTerm direction=float<cr>" "[T]erminal [F]loat")
          (mkKeymapd ["t"] "<esc>" "<C-\\><C-n>" "Terminal Normal Mode")

          (mkKeymapd ["n"] "<leader>rr" "<cmd>lua RunCode()<cr>" "[R]un [R]un Code")
        ];
      };
    };
  };
}
