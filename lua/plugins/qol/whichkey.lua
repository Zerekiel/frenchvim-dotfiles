return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.setup({
			preset = "helix",
			icons = {
				mappings = false,
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "➜", -- symbol used between a key and it's label
				group = "", -- symbol prepended to a group
			},
			win = {
				border = "rounded",
				padding = { 2, 2, 2, 2 },
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 4, -- spacing between columns
			},
			show_help = true,
		})

		-- local unicode icons
		local icons = require("core.icons")
		-- Which-key groups
		wk.add({
			{ "<leader>s", group = icons.whichkey.splits .. "  Splits" },
			{ "<leader>g", group = icons.whichkey.git .. "  Git" },
			{ "<leader>gc", group = icons.whichkey.git .. "  Git Conflict" },
			{ "<leader>c", group = icons.whichkey.todo .. " Todo comments" },
			{ "<leader>q", group = icons.whichkey.session .. "  Session" },
			{ "<leader>f", group = icons.whichkey.find .. "  Find" },
			{ "<leader>r", group = icons.whichkey.format .. "  Format" },
			{ "<leader>b", group = icons.whichkey.buffers .. "  Buffers" },
			{ "<leader>d", group = icons.whichkey.diagnostics .. "  Diagnostics" },
			{ "<leader>e", group = icons.whichkey.explorer .. "  Explorer" },
			{ "<leader>w", group = icons.whichkey.write .. "  Write" },
			{ "<leader>l", group = icons.whichkey.lsp .. "  LSP" },
			{ "<leader>t", group = icons.whichkey.terminal .. " Terminal" },
		})
	end,
}
