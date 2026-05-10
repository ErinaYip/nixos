{enabled, ...}: {
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

    nix.enable = true;
    markdown.enable = true;
    python.enable = true;
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
    # servers = {
    #   basedpyright = {
    #     enable = true;
    #     filetypes = ["python"];
    #     root_markers = ["pyproject.toml" "pyrightconfig.json" ".git" ".venv"];
    #   };
    # };
  };
}
