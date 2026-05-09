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
  in {
    programs.nvf = {
      enable = true;
      settings.vim = lib.mkMerge [
        (import ./toggterm.nix {inherit lib mkKeymap mkKeymapd mkKeymaps;})
        (import ./snacks.nix {inherit mkKeymap mkKeymapd mkKeymaps;})
        (import ./bufferline.nix {inherit mkKeymap mkKeymapd mkKeymaps;})
        (import ./keymaps.nix {inherit mkKeymap mkKeymapd mkKeymaps;})

        (import ./settings.nix)
        (import ./languages.nix)
        (import ./lualine.nix)
        (import ./blink-cmp.nix)

        {
          viAlias = false;
          vimAlias = true;
          lazy.enable = true;

          ui = {
            # borders.enable = true;
            noice.enable = true;
            colorizer.enable = true;
            # modes-nvim.enable = true;
            # illuminate.enable = true;
            breadcrumbs = {
              enable = true;
              navbuddy.enable = true;
            };
            # smartcolumn = {
            #   enable = true;
            #   setupOpts.custom_colorcolumn = {
            #     # this is a freeform module, it's `buftype = int;` for configuring column position
            #     nix = "110";
            #     ruby = "120";
            #     java = "130";
            #     go = ["90" "130"];
            #   };
            # };
            # fastaction.enable = true;
          };

          lsp = {
            enable = true;
          };

          debugger = {
            nvim-dap = {
              enable = true;
              ui.enable = true;
            };
          };

          visuals = {
            # nvim-scrollbar.enable = true;
            nvim-web-devicons.enable = true;
            # nvim-cursorline.enable = true;
            # fidget-nvim.enable = true;

            # highlight-undo.enable = true;
            # blink-indent.enable = true;
            indent-blankline.enable = true;

          };

          autopairs.nvim-autopairs.enable = true;

          # treesitter.context.enable = true;

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

          comments = {
            comment-nvim.enable = true;
          };
        }
      ];
    };
  };
}
