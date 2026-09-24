return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		version = "*",
		config = function()
			local bufferline = require("bufferline")
			local icons = require("core.icons")
			bufferline.setup({
				options = {
					always_show_bufferline = true,

					show_buffer_icons = true,
					get_element_icon = require("real-icons.integrations.bufferline").get_element_icon,

					-- Diagnostic LSP
					diagnostics = "nvim_lsp",

					-- Picker bufferline
					pick = {
						alphabet = "abcdefghijklmnopqrstuvwxyz",
					},

					diagnostics_indicator = function(_, _, diagnostics_dict, _)
						local s = ""

						for e, n in pairs(diagnostics_dict) do
							local sym = ({
								error = icons.diagnostic.error,
								warn = icons.diagnostic.warn,
								info = icons.diagnostic.info,
								hint = icons.diagnostic.hint,
							})[e]

							if sym then
								s = s .. sym .. n .. " "
							end
						end

						return s
					end,

					offsets = {
						{
							filetype = "neo-tree",
							text = "File Explorer",
							text_align = "center",
						},
					},
					separator_style = "thick",
					show_tab_indicators = true,
					tab_size = 20,
				},
			})
		end,
		keys = {
			{ "<Leader>bb", "<cmd>BufferLinePick<CR>", desc = "Select Buffer" },
			{ "<Leader>bn", "<cmd>BufferLineMoveNext<CR>", desc = "Move next" },
			{
				"<Leader>bc",
				function()
					require("mini.bufremove").delete(0, false)
				end,
				desc = "Close current buffer",
			},
			{
				"<Leader>bo",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Force close current buffer",
			},
			{ "<Leader>bD", "<cmd>BufferLinePickClose<CR>", desc = "Pick buffer to close" },
			{ "<Leader>bC", "<cmd>BufferLineCloseOthers<CR>", desc = "Close all other buffers" },
			{ "<leader>bv", "<cmd>vertical sbuffer<CR>", desc = "Open buffer in vsplit" },
		},
	},
}
