local clrs = require("catppuccin.palettes").get_palette()
local ctp_feline = require('catppuccin.groups.integrations.feline')

ctp_feline.setup({
    sett = {
        text = clrs.surface0,
        bkg = clrs.surface0,
        diffs = clrs.mauve,
        extras = clrs.overlay1,
        curr_file = clrs.maroon,
        curr_dir = clrs.flamingo,
        show_modified = true -- show if the file has been modified
    },
})

require("feline").setup {
    components = ctp_feline.get(),
}
