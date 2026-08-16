{
  lib,
  pkgs,
  enabled,
  default,
  hostName,
  ...
}: {
  diagnostics = {
    enable = true;
    config = {
      virtual_text = true;
    };
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
    enableDAP = true;

    nix = {
      enable = true;
      lsp.servers = ["nixd"];
    };
    markdown = enabled;
    python = {
      enable = true;
      format.type = ["ruff-fix" "ruff"];
      lsp.servers = ["basedpyright" "ruff"];
    };
    typescript = enabled;
    astro = enabled;
    scss = enabled;
    clang = enabled;
  };

  treesitter = {
    enable = true;
    # fold = true;
  };

  lsp = {
    enable = true;

    formatOnSave = true;
    inlayHints = enabled;
    lightbulb = enabled;
    trouble = enabled;
    # lspkind.enable = false;
    # lspsaga.enable = false;
    # lspSignature.enable = !isMaximal; # conflicts with blink in maximal
    # otter-nvim.enable = isMaximal;
    # nvim-docs-view.enable = isMaximal;
    # presets.harper.enable = isMaximal;
    servers = {
      nixd = {
        root_markers = ["flake.nix" ".git"];
        settings.nixd = {
          nixpkgs.expr = ''
            import (builtins.getFlake (builtins.toString ./.)).inputs.nixpkgs {
              system = "${default.system}";
              config.allowUnfree = true;
            }
          '';

          options = {
            nixos.expr = ''
              (builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${hostName}.options
            '';

            home-manager.expr = ''
              (builtins.getFlake (builtins.toString ./.)).homeConfigurations."${default.username}@${hostName}".options
            '';
          };

          formatting.command = [(lib.getExe pkgs.alejandra)];
        };
      };
      "marksman" = {
        filetypes = lib.mkForce ["markdown"];
      };
      # "astro-language-server" = {
      #   cmd = lib.mkForce [
      #     "env"
      #     "NODE_PATH=${pkgs.typescript}/lib/node_modules"
      #     "${pkgs.astro-language-server}/bin/astro-ls"
      #     "--stdio"
      #   ];
      #   init_options.typescript.tsdk = "${pkgs.typescript}/lib/node_modules/typescript/lib";
      # };
      "basedpyright" = {
        settings = {
          basedpyright = {
            analysis = {
              autoSearchPaths = true;
              typeCheckingMode = "basic";
              useLibraryCodeForTypes = true;
              diagnosticMode = "openFilesOnly";
            };
          };
        };
      };
      "mdx_analyzer" = {
        enable = true;
        cmd = [
          (lib.getExe pkgs.mdx-language-server)
          "--stdio"
        ];
        filetypes = ["mdx"];
        root_markers = ["package.json" ".git"];
      };
    };
  };

  diagnostics.nvim-lint.linters = {
    "cpplint" = {
      args = ["--filter=-legal/copyright"];
    };
  };

  formatter.conform-nvim.setupOpts.formatters = {
    "clang-format" = {
      prepend_args = ["-style=Google"];
    };
  };

  luaConfigRC.filetype = ''
    vim.filetype.add({ extension = { mdx = "mdx" } })
    vim.treesitter.language.register("markdown", "mdx")
  '';
}
