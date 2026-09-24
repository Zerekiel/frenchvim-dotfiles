return {
	{
		"nvim-lualine/lualine.nvim",
		--dependencies = { "nvim-tree/nvim-web-devicons" },

		config = function()
			local lualine = require("lualine")

			local function mode()
				-- Map of modes to their respective shorthand indicators
				local mode_map = {
					n = "N", -- Normal mode
					i = "I", -- Insert mode
					v = "V", -- Visual mode
					[""] = "V", -- Visual block mode
					V = "V", -- Visual line mode
					c = "C", -- Command-line mode
					no = "N", -- NInsert mode
					s = "S", -- Select mode
					S = "S", -- Select line mode
					ic = "I", -- Insert mode (completion)
					R = "R", -- Replace mode
					Rv = "R", -- Virtual Replace mode
					cv = "C", -- Command-line mode
					ce = "C", -- Ex mode
					r = "R", -- Prompt mode
					rm = "M", -- More mode
					["r?"] = "?", -- Confirm mode
					["!"] = "!", -- Shell mode
					t = "T", -- Terminal mode
				}
				-- Return the mode shorthand or [UNKNOWN] if no match
				return mode_map[vim.fn.mode()] or "[UNKNOWN]"
			end

			local function linter()
				local lint = require("lint")
				local linters = lint.linters_by_ft[vim.bo.filetype]

				if not linters or #linters == 0 then
					return ""
				end

				return "󰁨 " .. table.concat(linters, ", ")
			end

			lualine.setup({
				options = {
					theme = "ayu_dark",
					icons_enabled = true,
					globalstatus = true,

					-- On reprend le style épuré d'Eviline
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},

				sections = {

					-- REMINDER OF LUALINE SECTION SETUP
					-- +-------------------------------------------------+
					-- | A | B | C                             X | Y | Z |
					-- +-------------------------------------------------+

					-- Gauche
					lualine_a = {
						mode,
					},

					lualine_b = {
						"branch",
					},

					lualine_c = {
						{
							require("real-icons.integrations.lualine").component,
							padding = { left = 1 },
							separator = "",
						},
						{
							"filename",
							path = 1,
						},
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = {
								error = " ",
								warn = " ",
								info = " ",
								hint = "󰌵 ",
							},
						},
					},

					-- Centre
					lualine_x = {
						{
							linter,
						},
						{
							function()
								local clients = vim.lsp.get_clients({ bufnr = 0 })

								if #clients == 0 then
									return ""
								end

								return "󰒋 " .. clients[1].name
							end,
						},
					},

					-- Droite
					lualine_y = {
						{
							"diff",
							symbols = {
								added = " ",
								modified = "󰝤 ",
								removed = " ",
							},
							source = function()
								local status = vim.b.gitsigns_status_dict
								if not status then
									return nil
								end
								return {
									added = status.added,
									modified = status.changed,
									removed = status.removed,
								}
							end,
						},
					},

					lualine_z = {
						"location",
					},
				},

				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						{
							"filename",
							path = 1,
						},
					},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {
						"location",
					},
				},
			})
		end,
	},
}
