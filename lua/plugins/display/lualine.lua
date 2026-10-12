return {
	{
		"nvim-lualine/lualine.nvim",

		config = function()
			local lualine = require("lualine")

			-- Palette inspiree d'Ayu Dark
			local colors = {
				bg = "#0B0E14",
				surface = "#11151C",
				muted = "#565B66",
				fg = "#BFBDB6",
				yellow = "#E6B450",
				blue = "#73D0FF",
				green = "#7FD962",
				orange = "#FFAD66",
				red = "#F07178",
				purple = "#D2A6FF",
				cyan = "#95E6CB",
			}

			-- Theme personnalise base sur Ayu Dark
			local theme = require("lualine.themes.ayu_dark")

			local function style_section(section, bg, fg)
				section.bg = bg
				section.fg = fg
			end

			-- Fond uniforme pour les sections secondaires
			for _, mode in pairs(theme) do
				if type(mode) == "table" then
					if mode.a then
						mode.a.gui = "bold"
					end

					for _, section_name in ipairs({ "b", "c", "x", "y", "z" }) do
						if mode[section_name] then
							style_section(mode[section_name], colors.surface, colors.fg)
						end
					end
				end
			end

			-- Conserver les couleurs originales d'Ayu Dark pour le bloc du mode Vim
			local original_theme = require("lualine.themes.ayu_dark")

			for mode_name, mode_config in pairs(theme) do
				if
					type(mode_config) == "table"
					and mode_config.a
					and original_theme[mode_name]
					and original_theme[mode_name].a
				then
					theme[mode_name].a = vim.deepcopy(original_theme[mode_name].a)
					theme[mode_name].a.gui = "bold"
				end
			end

			-- Mode Vim raccourci
			local function mode()
				local mode_map = {
					n = "N",
					i = "I",
					v = "V",
					["\22"] = "VB",
					V = "VL",
					c = "C",
					no = "N",
					s = "S",
					S = "SL",
					ic = "I",
					R = "R",
					Rv = "RV",
					cv = "C",
					ce = "C",
					r = "R",
					rm = "M",
					["r?"] = "?",
					["!"] = "!",
					t = "T",
				}

				return mode_map[vim.fn.mode()] or "?"
			end

			-- Linters actifs pour le filetype
			local function linter()
				local ok, lint = pcall(require, "lint")
				if not ok then
					return ""
				end

				local linters = lint.linters_by_ft[vim.bo.filetype]

				if not linters or #linters == 0 then
					return ""
				end

				return "󰁨 " .. table.concat(linters, ", ")
			end

			-- Client LSP actif
			local function lsp()
				local clients = vim.lsp.get_clients({ bufnr = 0 })

				if #clients == 0 then
					return ""
				end

				return "󰒋 " .. clients[1].name
			end

			lualine.setup({
				options = {
					theme = theme,
					globalstatus = true,
					icons_enabled = true,

					component_separators = {
						left = "",
						right = "│",
					},

					section_separators = {
						left = "",
						right = "",
					},

					disabled_filetypes = {
						statusline = {},
					},
				},

				sections = {
					lualine_a = {
						{
							mode,
							padding = { left = 1, right = 1 },
						},
					},

					lualine_b = {
						{
							"branch",
							icon = "",
							color = { fg = colors.orange, gui = "bold" },
							padding = { left = 1, right = 1 },
						},
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
							padding = { left = 1, right = 1 },
							separator = "",
						},
					},

					lualine_c = {
						{
							function()
								return "│"
							end,
							color = { fg = colors.muted },
							padding = { left = 1, right = 1 },
						},
						{
							require("real-icons.integrations.lualine").component,
							padding = { left = 1, right = 0 },
							separator = "",
						},
						{
							"filename",
							path = 1,
							symbols = {
								modified = " ●",
								readonly = " 󰌾",
								unnamed = "[No Name]",
							},
							color = { fg = colors.fg },
							padding = { left = 1, right = 1 },
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
							colored = true,
							update_in_insert = false,
						},
					},

					lualine_x = {
						{
							linter,
							color = { fg = colors.orange },
							padding = { left = 1, right = 1 },
						},
						{
							lsp,
							color = { fg = colors.blue },
							padding = { left = 1, right = 1 },
						},
					},

					lualine_y = {},

					lualine_z = {
						{
							"location",
							color = {
								fg = colors.white,
								gui = "bold",
							},
							padding = { left = 1, right = 1 },
						},
					},
				},

				inactive_sections = {
					lualine_a = {},
					lualine_b = {},

					lualine_c = {
						{
							"filename",
							path = 1,
							color = { fg = colors.muted },
						},
					},

					lualine_x = {},
					lualine_y = {},

					lualine_z = {
						{
							"location",
							color = { fg = colors.muted },
						},
					},
				},
			})
		end,
	},
}
