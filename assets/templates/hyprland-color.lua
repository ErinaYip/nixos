local c = {
<* for name, value in colors *>
    {{name}} = "0xff{{value.default.hex_stripped}}",
<* endfor *>
}

hl.config({
    general = {
        -- General
        ["col.active_border"] = c.primary,
        ["col.inactive_border"] = c.outline,
    }
})
