{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "cli";
    name = "nvim";

    configFn = _: let
      mkKeymap = mode: key: action: desc: {
        silent ? true,
        noremap ? true,
      }: {
        inherit mode key action silent noremap desc;
      };
      mkKeymapd = mode: key: action: desc: mkKeymap mode key action desc {};
      mkKeymaps = mode: key: action: mkKeymap mode key action "" {};
      inherit (lib.generators) mkLuaInline;

      arg = {inherit lib pkgs mkLuaInline enabled disabled mkKeymap mkKeymapd mkKeymaps;};
    in {
      programs.nvf = {
        enable = true;
        settings.vim = lib.mkMerge [
          (import ./toggterm.nix arg)
          (import ./snacks.nix arg)
          (import ./bufferline.nix arg)
          (import ./keymaps.nix arg)
          (import ./ui.nix arg)
          (import ./lsp.nix arg)

          (import ./settings.nix)
          (import ./lualine.nix)
          (import ./blink-cmp.nix)

          {
            viAlias = false;
            vimAlias = true;
            lazy = enabled;

            visuals = {
              nvim-web-devicons = enabled;
              fidget-nvim = enabled;
              nvim-cursorline = {
                enable = true;
                setupOpts = {
                  cursorline.enable = true;
                  cursorword.enable = true;
                  disable_filetypes = ["snacks_dashboard"];
                };
              };
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

            notify.nvim-notify = enabled;
            comments.comment-nvim = enabled;
          }
        ];
      };

      home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };
  }
