return {
	"akinsho/git-conflict.nvim",
	version = "^2.1.0",
	init = function()
		require("git-conflict").setup({
			default_mappings = false,
			disable_diagnostics = true,
		})
	end,
	config = function()
		local pickers = require("telescope.pickers")
		local finders = require("telescope.finders")
		local conf = require("telescope.config").values
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		local function git_conflicts()
			local output = vim.fn.systemlist({
				"git",
				"diff",
				"--name-only",
				"--diff-filter=U",
			})

			if vim.v.shell_error ~= 0 then
				vim.notify("Not inside a Git repository", vim.log.levels.ERROR)
				return
			end

			if #output == 0 then
				vim.notify("No conflicted files 🎉", vim.log.levels.INFO)
				return
			end

			pickers
				.new({}, {
					prompt_title = "Git Conflicts",
					finder = finders.new_table({
						results = output,
						entry_maker = function(entry)
							return {
								value = entry,
								display = entry,
								ordinal = entry,
								path = entry,
							}
						end,
					}),
					sorter = conf.generic_sorter({}),
					previewer = conf.file_previewer({}),
					attach_mappings = function(prompt_bufnr, map)
						local function open_file()
							local selection = action_state.get_selected_entry()

							if not selection then
								return
							end

							actions.close(prompt_bufnr)

							vim.cmd.edit(vim.fn.fnameescape(selection.path))
						end

						map("i", "<CR>", open_file)
						map("n", "<CR>", open_file)

						return true
					end,
				})
				:find()
		end

		vim.keymap.set("n", "<leader>gcl", git_conflicts, {
			desc = "List Git conflicts",
		})
	end,
	keys = {
		{ "<leader>gco", ":GitConflictChooseOurs<cr>", desc = "Choose ours" },
		{ "<leader>gct", ":GitConflictChooseTheirs<cr>", desc = "Choose theirs" },
		{ "<leader>gcb", ":GitConflictChooseBoth<cr>", desc = "Choose both" },
		{ "<leader>gc0", ":GitConflictChooseNone<cr>", desc = "Choose none" },
		{ "<leader>gcn", ":GitConflictNextConflict<cr>", desc = "Next conflict" },
		{ "<leader>gcp", ":GitConflictPrevConflict<cr>", desc = "Previous conflict" },
	},
}
