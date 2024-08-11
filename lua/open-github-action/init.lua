local keymaps = require("open-github-action.keymaps")
local main = require("open-github-action.main")

local M = {}

local options = {
	keymaps = {
		enabled = true,
	},
}

function M.get_options()
	return options
end

function M.setup(opts)
	options = vim.tbl_deep_extend("force", options, opts or {})

	vim.api.nvim_create_user_command("OpenGithubAction", main.open_github_action, {})

	if options.keymaps.enabled then
		keymaps.create_default_keymaps()
	end
end

return M
