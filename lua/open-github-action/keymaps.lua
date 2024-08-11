local M = {}

function M.create_default_keymaps()
	vim.keymap.set(
		"n",
		"gwx",
		"<cmd>OpenGithubAction<CR>",
		{ noremap = true, silent = true, desc = "Open GitHub Action" }
	)
end

return M
