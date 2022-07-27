-- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local wikiscope = function(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "vw",
        finder = finders.new_table { results = vim.fn.readdir("/home/craggle/vimwiki/") },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.cmd('e '..os.getenv("HOME")..'vimwiki/'..selection[1])
            end)
            return true
        end,
    }):find()
end

-- vw(require("telescope.themes").get_dropdown{})
return wikiscope
