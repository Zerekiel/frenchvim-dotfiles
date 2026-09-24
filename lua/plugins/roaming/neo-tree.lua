return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-mini/mini.icons",
		},
		lazy = false,
		keys = {
			{ "<leader>e", ":Neotree toggle<cr>", desc = "toggle nvim-tree" },
		},
		config = function()
			local icons = require("core.icons")
			require("neo-tree").setup({
				close_if_last_window = true,
				auto_clean_after_session_restore = true,

				window = {
					width = 25,
					auto_expand_width = true,
				},

				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = true,
						hide_by_name = {
							".git",
							".DS_Store",
						},
					},
				},

				source_selector = {
					winbar = true,
					statusline = true,
				},
				default_component_configs = {
					git_status = {
						symbols = icons.git,
					},
				},
			})
		end,
	},
}
