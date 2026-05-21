{
  lib,
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
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
      home-manager.sharedModules = [
        inputs.nvf.homeManagerModules.default
      ];

      erinite.home.programs.nvf = {
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
              colorizer = {
                enable = true;
                setupOpts.filetypes = {
                  "*" = {};
                };
              };
              fastaction = enabled;
              nvim-ufo = {
                enable = true;
                setupOpts = {
                  fold_virt_text_handler = mkLuaInline ''
                     function(virtText, lnum, endLnum, width, truncate)
                        local newVirtText = {}
                        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
                        local sufWidth = vim.fn.strdisplaywidth(suffix)
                        local targetWidth = width - sufWidth
                        local curWidth = 0
                        for _, chunk in ipairs(virtText) do
                            local chunkText = chunk[1]
                            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                            if targetWidth > curWidth + chunkWidth then
                                table.insert(newVirtText, chunk)
                            else
                                chunkText = truncate(chunkText, targetWidth - curWidth)
                                local hlGroup = chunk[2]
                                table.insert(newVirtText, {chunkText, hlGroup})
                                chunkWidth = vim.fn.strdisplaywidth(chunkText)
                                -- str width returned from truncate() may less than 2nd argument, need padding
                                if curWidth + chunkWidth < targetWidth then
                                    suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                                end
                                break
                            end
                            curWidth = curWidth + chunkWidth
                        end
                        table.insert(newVirtText, {suffix, 'MoreMsg'})
                        return newVirtText
                    end
                  '';
                };
              };
              breadcrumbs = {
                enable = true;
                navbuddy.enable = true;
              };
            };

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
              # highlight-undo = {
              #   enable = true;
              #   setupOpts = {
              #     ignored_filetypes = ["snacks_dashboard"];
              #   };
              # };
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

      environment.variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };
  }
