{mkLuaInline, ...}: {
  autocomplete.blink-cmp = {
    enable = true;
    setupOpts = {
      keymap = {
        preset = "none";
        "<C-space>" = ["show" "show_documentation" "hide_documentation"];
        "<cr>" = ["select_and_accept" "fallback"];

        "<Tab>" = ["select_next" "fallback" "snippet_forward"];
        "<S-Tab>" = ["select_prev" "fallback" "snippet_backward"];
        # "<Down>" = [ "select_next" "fallback" "snippet_forward" ];
        # "<Up>" = [ "select_prev" "fallback" "snippet_backward" ];
        "<C-n>" = ["select_next" "fallback" "snippet_forward"];
        "<C-p>" = ["select_prev" "fallback" "snippet_backward"];

        "<C-b>" = ["scroll_documentation_up" "fallback"];
        "<C-f>" = ["scroll_documentation_down" "fallback"];
      };

      appearance = {
        nerd_font_variant = "mono";
        use_nvim_cmp_as_default = true;
      };

      completion = {
        keyword.range = "full";
        list.selection = {
          preselect = false;
          auto_insert = false;
        };
        # menu = {
        #   enabled = true;
        #   border = "rounded";
        # };
        menu.draw.components.label.highlight = mkLuaInline ''
          function(ctx)
            local label = ctx.label
            local label_hl = ctx.deprecated and "BlinkCmpLabelDeprecated" or (ctx.kind_hl or "BlinkCmpLabel")
            local highlights = {
              { 0, #label, group = label_hl },
            }

            if ctx.label_detail then
              table.insert(highlights, { #label, #label + #ctx.label_detail, group = "BlinkCmpLabelDetail" })
            end

            if vim.list_contains(ctx.self.treesitter, ctx.source_id) and not ctx.deprecated then
              vim.list_extend(highlights, require("blink.cmp.completion.windows.render.treesitter").highlight(ctx))
            end

            for _, idx in ipairs(ctx.label_matched_indices) do
              table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
            end

            return highlights
          end
        '';
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 150;
          # window = {
          #   border = "rounded";
          # };
        };
      };
    };
  };
}
