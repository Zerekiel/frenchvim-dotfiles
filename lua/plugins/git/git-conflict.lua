return {
	"akinsho/git-conflict.nvim",
	version = "^2.1.0",
	init = function()
		require("git-conflict").setup({
			default_mappings = false,
			disable_diagnostics = true,
		})
	end,
	keys = {
		{ "<leader>gco", ":GitConflictChooseOurs<cr>", desc = "Choose ours" },
		{ "<leader>gct", ":GitConflictChooseTheirs<cr>", desc = "Choose theirs" },
		{ "<leader>gcb", ":GitConflictChooseBoth<cr>", desc = "Choose both" },
		{ "<leader>gc0", ":GitConflictChooseNone<cr>", desc = "Choose none" },
		{ "<leader>gcn", ":GitConflictNextConflict<cr>", desc = "Next conflict" },
		{ "<leader>gcp", ":GitConflictPrevConflict<cr>", desc = "Previous conflict" },
	},
}
