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
      "astro-language-server" = {
        cmd = lib.mkForce [
          "env"
          "NODE_PATH=${pkgs.typescript}/lib/node_modules"
          "${pkgs.astro-language-server}/bin/astro-ls"
          "--stdio"
        ];
      };
    };
  };
}
