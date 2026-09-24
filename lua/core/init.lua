if vim.loader then
	vim.loader.enable()
end

require("core.options")
require("core.keymaps")
require("core.lazy")
require("core.lsp")
--require("core.icons")

local cmd = vim.cmd

cmd.colorscheme("ayu")

-- highlight upon yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 300,
		})
	end,
})
