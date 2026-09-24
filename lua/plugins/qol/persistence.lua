return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {},
	config = function(_, opts)
		require("persistence").setup(opts)

		vim.api.nvim_create_autocmd("User", {
			pattern = "PersistenceLoadPost",
			callback = function()
				local buf = vim.api.nvim_get_current_buf()
				if vim.bo[buf].filetype == "" then
					vim.cmd("filetype detect")
				end
			end,
		})
	end,
}
