local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup{
    defaults = {
        mappings = {
            n = {
                ["q"] = actions.close
            },
        },
    }
}