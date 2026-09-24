return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		indent = { enabled = true },
		lazygit = {
			enable = true,
			configure = true,
		},
		notifier = {
			enabled = true,
			timeout = 3000,
		},
	},
}
