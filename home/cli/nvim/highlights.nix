{
  luaConfigRC.kind-highlights = ''
    local function apply_kind_highlights()
      local function get_fg(groups)
        for _, group in ipairs(groups) do
          local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
          if ok and hl and hl.fg then
            return string.format("#%06x", hl.fg)
          end
        end

        return nil
      end

      local function set_fg(groups, targets)
        local fg = get_fg(groups)
        if fg == nil then
          return
        end

        for _, target in ipairs(targets) do
          vim.api.nvim_set_hl(0, target, { fg = fg })
        end
      end

      local cmp_kinds = {
        Text = { "String", "Normal" },
        Method = { "Function" },
        Function = { "Function" },
        Constructor = { "Special", "Function" },
        Field = { "Identifier" },
        Variable = { "Identifier" },
        Class = { "Type" },
        Interface = { "Type" },
        Module = { "Include", "Type" },
        Property = { "Identifier" },
        Unit = { "Number" },
        Value = { "String", "Constant" },
        Enum = { "Type" },
        Keyword = { "Keyword", "Statement" },
        Snippet = { "Special" },
        Color = { "Special" },
        File = { "Directory" },
        Reference = { "Underlined", "Identifier" },
        Folder = { "Directory" },
        EnumMember = { "Constant" },
        Constant = { "Constant" },
        Struct = { "Structure", "Type" },
        Event = { "Special" },
        Operator = { "Operator" },
        TypeParameter = { "Type" },
      }

      for kind, groups in pairs(cmp_kinds) do
        set_fg(groups, {
          "CmpItemKind" .. kind,
          "BlinkCmpKind" .. kind,
        })
      end

      local symbol_kinds = {
        File = cmp_kinds.File,
        Module = cmp_kinds.Module,
        Namespace = cmp_kinds.Module,
        Package = cmp_kinds.Module,
        Class = cmp_kinds.Class,
        Method = cmp_kinds.Method,
        Property = cmp_kinds.Property,
        Field = cmp_kinds.Field,
        Constructor = cmp_kinds.Constructor,
        Enum = cmp_kinds.Enum,
        Interface = cmp_kinds.Interface,
        Function = cmp_kinds.Function,
        Variable = cmp_kinds.Variable,
        Constant = cmp_kinds.Constant,
        String = { "String" },
        Number = { "Number" },
        Boolean = { "Boolean", "Constant" },
        Array = cmp_kinds.Struct,
        Object = cmp_kinds.Struct,
        Key = cmp_kinds.Property,
        Null = { "Comment", "Constant" },
        EnumMember = cmp_kinds.EnumMember,
        Struct = cmp_kinds.Struct,
        Event = cmp_kinds.Event,
        Operator = cmp_kinds.Operator,
        TypeParameter = cmp_kinds.TypeParameter,
      }

      for kind, groups in pairs(symbol_kinds) do
        set_fg(groups, {
          "NavicIcons" .. kind,
          "Navbuddy" .. kind,
        })
      end
    end

    apply_kind_highlights()

    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("KindHighlights", { clear = true }),
      callback = apply_kind_highlights,
    })
  '';
}
