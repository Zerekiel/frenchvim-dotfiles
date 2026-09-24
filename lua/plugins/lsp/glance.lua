return {
	"dnlhc/glance.nvim",
	config = function()
		require("glance").setup()

		vim.keymap.set("n", "gR", "<CMD>Glance references<CR>", { desc = "Show LSP references" })
	end,
}
