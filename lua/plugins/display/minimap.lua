return {
	"Isrothy/neominimap.nvim",
	init = function()
		vim.opt.wrap = false -- Recommended
		vim.opt.sidescrolloff = 36 -- It's recommended to set a large value
		vim.g.neominimap = {
			-- Enable the plugin by default
			auto_enable = true,
			minimap_width = 14,

			-- Log level
			log_level = vim.log.levels.OFF,

			-- Notification level
			notification_level = vim.log.levels.INFO,

			-- Path to the log file
			log_path = vim.fn.stdpath("data") .. "/neominimap.log",

			-- Minimap will not be created for buffers of these types
			exclude_filetypes = { "help" },

			-- Minimap will not be created for buffers of these types
			exclude_buftypes = {
				"nofile",
				"nowrite",
				"quickfix",
				"terminal",
				"prompt",
			},
			-- Diagnostic integration
			diagnostic = {
				enabled = true,
				severity = vim.diagnostic.severity.WARN,
				priority = {
					ERROR = 100,
					WARN = 90,
					INFO = 80,
					HINT = 70,
				},
			},

			treesitter = {
				enabled = true,
				priority = 200,
			},
			-- Border style of the floating window
			-- Accepts all usual border style options (e.g., "single", "double")
			window_border = "single",
		}
	end,
}
