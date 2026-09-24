return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules/",
					"%.git/",
					vim.fn.stdpath("data") .. "/lazy/",
					"^lazy/",
				},

				mappings = {
					i = {
						["qq"] = actions.close,
						["<esc><esc>"] = actions.close,
					},

					n = {
						["<esc>"] = false,
						["qq"] = actions.close,
						["<esc><esc>"] = actions.close,
					},
				},

				file_sorter = require("telescope.sorters").get_fuzzy_file,
			},

			pickers = {
				live_grep = {
					additional_args = function()
						return {
							"--glob",
							"!node_modules/**",
							"--glob",
							"!.git/**",
							"--glob",
							"!" .. vim.fn.stdpath("data") .. "/lazy/**",
						}
					end,
				},
			},
		})

		telescope.load_extension("file_browser")
		telescope.load_extension("fzf")

		-- Files
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "Find word" })
		vim.keymap.set("n", "<leader>fW", builtin.grep_string, { desc = "Find word under cursor" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help" })
		vim.keymap.set("n", "<leader>fb", ":Telescope file_browser path=%:p:h<CR>", { desc = "File browser" })

		-- Git
		vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
	end,
}
