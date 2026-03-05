{ ... }: {
  plugins.blink-cmp = {
    enable = true;
    setupLspCapabilities = false;
    lazyLoad.settings.event = [ "InsertEnter" "CmdlineEnter" ];
  };
  plugins.blink-cmp.settings.keymap = {
    preset = "none";
    "<C-space>" = [ "show" "show_documentation" "hide_documentation" ];
    "<cr>" = [ "select_and_accept" "fallback" ];

    "<Tab>" = [ "select_next" "fallback" "snippet_forward" ];
    "<S-Tab>" = [ "select_prev" "fallback" "snippet_backward" ];
    # "<Down>" = [ "select_next" "fallback" "snippet_forward" ];
    # "<Up>" = [ "select_prev" "fallback" "snippet_backward" ];
    "<C-n>" = [ "select_next" "fallback" "snippet_forward" ];
    "<C-p>" = [ "select_prev" "fallback" "snippet_backward" ];

    "<C-b>" = [ "scroll_documentation_up" "fallback" ];
    "<C-f>" = [ "scroll_documentation_down" "fallback" ];
  };

  plugins.blink-cmp.settings.appearance = {
    nerd_font_variant = "mono";
    use_nvim_cmp_as_default = true;
  };

  plugins.blink-cmp.settings.completion = {
    keyword.range = "full";
    list.selection = {
      preselect = false;
      auto_insert = false;
    };
    menu = {
      enabled = true;
      border = "rounded";
    };
    documentation = {
      auto_show = true;
      auto_show_delay_ms = 150;
      window = {
        border = "rounded";
      };
    };
  };

  plugins.blink-cmp.settings.signature = {
    enabled = true;
    window = {
      border = "rounded";
    };
  };

  plugins.blink-cmp.settings.sources = {
    default = [ "lsp" "path" "buffer" ];
  };
}
