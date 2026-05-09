{enabled, ...}: {
  diagnostics = {
    enable = true;
    config = {
      virtual_text = true;
    };
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
  };
}
