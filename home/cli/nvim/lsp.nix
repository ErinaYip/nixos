{
  lib,
  pkgs,
  enabled,
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

    nix = enabled;
    markdown = enabled;
    python = enabled;
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
      "marksman" = {
        filetypes = lib.mkForce ["markdown"];
      };
      "astro-language-server" = {
        cmd = lib.mkForce [
          "env"
          "NODE_PATH=${pkgs.typescript}/lib/node_modules"
          "${pkgs.astro-language-server}/bin/astro-ls"
          "--stdio"
        ];
      };
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
