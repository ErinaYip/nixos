{lib, ...}:
with lib; {
  luaConfigRC.ui-toggles = ''
    local t = require("snacks").toggle
    ${concatStringsSep "\n" (
      mapAttrsToList (key: expr: ''${expr}:map("<leader>u${key}")'') {
        "a" = "t.animate()";
        "b" = "t.option('background', {off = 'light', on = 'dark', name = 'Dark Background'})";
        "c" = "t.option('conceallevel', {off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = 'Conceal'})";
        "d" = "t.diagnostics()";
        "D" = "t.dim()";
        "f" = "t.new({id = 'format_global', name = 'Format Global', get = function() return vim.g.formatsave and true or false end, set = function(state) vim.g.formatsave = state end})";
        "F" = "t.new({id = 'format_buffer', name = 'Format Buffer', get = function() return not vim.b.disableFormatSave end, set = function(state) vim.b.disableFormatSave = not state end})";
        "g" = "t.new({id = 'indent_guides', name = 'Indent Guides', get = function() local ok, c = pcall(require, 'ibl.config') return ok and c.get_config(-1).enabled or false end, set = function(state) local ok, ibl = pcall(require, 'ibl') if ok then ibl.update({enabled = state}) end end})";
        "h" = "t.inlay_hints()";
        "l" = "t.line_number()";
        "L" = "t.option('relativenumber', {name = 'Relative Number'})";
        "s" = "t.option('spell', {name = 'Spelling'})";
        "S" = "t.scroll()";
        "T" = "t.treesitter()";
        "w" = "t.option('wrap', {name = 'Wrap'})";
        "W" = "t.option('list', {name = 'Invisibles'})";
        "z" = "t.zen()";
        "Z" = "t.zoom()";
      }
    )}
  '';
}
