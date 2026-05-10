{
  lib,
  inputs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    category = "cli";
    name = "nvim";

    imports = [inputs.nvf.nixosModules.default];

    configFn = _: let
      mkKeymap = mode: key: action: desc: {
        silent ? true,
        noremap ? true,
      }: {
        inherit mode key action silent noremap desc;
      };
      mkKeymapd = mode: key: action: desc: mkKeymap mode key action desc {};
      mkKeymaps = mode: key: action: mkKeymap mode key action "" {};

      arg = {inherit lib enabled disabled mkKeymap mkKeymapd mkKeymaps;};
    in {
      programs.nvf = {
        enable = true;
        settings.vim = lib.mkMerge [
          (import ./toggterm.nix arg)
          (import ./snacks.nix arg)
          (import ./bufferline.nix arg)
          (import ./keymaps.nix arg)
          (import ./lsp.nix arg)

          (import ./settings.nix)
          (import ./lualine.nix)
          (import ./blink-cmp.nix)

          {
            viAlias = false;
            vimAlias = true;
            lazy = enabled;

            ui = {
              noice = enabled;
              colorizer = enabled;
              fastaction = enabled;
              breadcrumbs = {
                enable = true;
                navbuddy.enable = true;
              };
            };

            visuals = {
              nvim-web-devicons = enabled;
              # nvim-cursorline.enable = true;
              # fidget-nvim.enable = true;

              # highlight-undo.enable = true;
              # blink-indent.enable = true;
              indent-blankline = enabled;
            };

            autopairs.nvim-autopairs = enabled;

            binds = {
              whichKey = enabled;
              cheatsheet = enabled;
            };

            git = {
              enable = true;
              gitsigns.enable = true;
            };

            notify = {
              nvim-notify = enabled;
            };

            comments = {
              comment-nvim = enabled;
            };
          }
        ];
      };
    };
  }
