return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		vim.api.nvim_set_hl(0, "FrenchBlue", {
			fg = "#0055A4",
		})

		vim.api.nvim_set_hl(0, "FrenchWhite", {
			fg = "#FFFFFF",
		})

		vim.api.nvim_set_hl(0, "FrenchRed", {
			fg = "#EF4135",
		})

		dashboard.section.header.val = {
			"######################################################",
			"######################################################",
			"##################    FrenchVim     ##################",
			"######################################################",
			"######################################################",
		}

		dashboard.section.header.opts.hl = {
			{
				{ "FrenchBlue", 0, 18 },
				{ "FrenchWhite", 18, 36 },
				{ "FrenchRed", 36, -1 },
			},
			{
				{ "FrenchBlue", 0, 18 },
				{ "FrenchWhite", 18, 36 },
				{ "FrenchRed", 36, -1 },
			},
			{
				{ "FrenchBlue", 0, 18 },
				{ "FrenchWhite", 18, 36 },
				{ "FrenchRed", 36, -1 },
			},
			{
				{ "FrenchBlue", 0, 18 },
				{ "FrenchWhite", 18, 36 },
				{ "FrenchRed", 36, -1 },
			},
			{
				{ "FrenchBlue", 0, 18 },
				{ "FrenchWhite", 18, 36 },
				{ "FrenchRed", 36, -1 },
			},
		}
		-- Set heading info
		local date = os.date("%a %d %b")

		local datetime = os.date(" %H:%M")

		local hi_top_section = {
			type = "text",
			val = "┌────────────   Today is "
				.. date
				.. " ────────────┐",
			opts = {
				position = "center",
			},
		}

		local hi_middle_section = {
			type = "text",
			val = "│                                                │",
			opts = {
				position = "center",
			},
		}

		local hi_bottom_section = {
			type = "text",
			val = "└───══───══───══───  "
				.. datetime
				.. "  ───══───══───══────┘",
			opts = {
				position = "center",
			},
		}

		--
		-- Set Buttons
		--

		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>Neotree toggle<CR>"),
			dashboard.button("SPC ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button(
				"SPC qs",
				"󰁯  > Restore Session For Current Directory",
				[[<cmd> lua require('persistence').load() <CR>]]
			),
			dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
		}

		--
		-- Set Footer
		--

		local function footer()
			local plugins = require("lazy").stats().count
			local v = vim.version()
			return string.format(" v%d.%d.%d  󰂖 %d ", v.major, v.minor, v.patch, plugins)
		end

		dashboard.section.footer.val = {
			footer(),
		}

		dashboard.section.footer.opts = {
			position = "center",
			hl = "FrenchVimFooter",
		}

		local function padding()
			return math.max(0, math.floor((vim.o.lines - 21) / 2))
		end

		--
		-- Setup
		--
		local opts = {
			layout = {
				{ type = "padding", val = padding },
				dashboard.section.header,
				{ type = "padding", val = 1 },
				hi_top_section,
				hi_middle_section,
				hi_bottom_section,
				{ type = "padding", val = 2 },
				dashboard.section.buttons,
				{ type = "padding", val = 1 },
				dashboard.section.footer,
			},
			opts = {
				margin = 5,
			},
		}

		-- Send config to alpha
		alpha.setup(opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
