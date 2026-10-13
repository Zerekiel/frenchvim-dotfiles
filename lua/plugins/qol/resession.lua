return {
	{
		"stevearc/resession.nvim",
		lazy = false,
		opts = {
			buf_filter = function(bufnr)
				if not vim.api.nvim_buf_is_valid(bufnr) then
					return false
				end

				local ft = vim.bo[bufnr].filetype

				local function has_git_conflicts(bufnr)
					local ok, git_conflict = pcall(require, "git-conflict")
					if not ok then
						return false
					end

					local success, count = pcall(git_conflict.conflict_count, bufnr)
					return success and count > 0
				end

				-- Buffers that should never be persisted
				local ignored_filetypes = {
					gitcommit = true,
					gitrebase = true,
				}

				if ignored_filetypes[ft] then
					return false
				end

				if has_git_conflicts(bufnr) then
					return false
				end

				return require("resession").default_buf_filter(bufnr)
			end,
		},

		config = function(_, opts)
			local resession = require("resession")
			resession.setup(opts)

			local group = vim.api.nvim_create_augroup("UserResession", { clear = true })

			local function cwd_session()
				return vim.fn.getcwd()
			end

			-- Check whether at least one useful buffer exists
			local function has_restorable_buffer()
				for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
					if opts.buf_filter(bufnr) then
						return true
					end
				end

				return false
			end

			local function save_session(name, session_opts)
				if not has_restorable_buffer() then
					return
				end

				resession.save(name, session_opts)
			end

			-- Remember whether stdin was provided
			vim.api.nvim_create_autocmd("StdinReadPre", {
				group = group,
				callback = function()
					vim.g.resession_stdin = true
				end,
			})

			-- Restore only when Neovim starts without file arguments
			vim.api.nvim_create_autocmd("VimEnter", {
				group = group,
				nested = true,
				callback = function()
					if vim.fn.argc(-1) ~= 0 or vim.g.resession_stdin then
						return
					end

					resession.load(cwd_session(), {
						dir = "dirsession",
						silence_errors = true,
					})
				end,
			})

			-- Save project session and last session before exit
			vim.api.nvim_create_autocmd("VimLeavePre", {
				group = group,
				callback = function()
					save_session(cwd_session(), {
						dir = "dirsession",
						notify = false,
					})
				end,
			})

			-- Session commands
			vim.api.nvim_create_user_command("SessionSave", function()
				save_session(cwd_session(), {
					dir = "dirsession",
				})
			end, {})

			vim.api.nvim_create_user_command("SessionLoad", function()
				resession.load(cwd_session(), {
					dir = "dirsession",
				})
			end, {})

			vim.api.nvim_create_user_command("SessionLast", function()
				resession.load("last")
			end, {})

			vim.api.nvim_create_user_command("SessionDelete", function()
				resession.delete(cwd_session(), {
					dir = "dirsession",
				})
			end, {})

			vim.keymap.set("n", "<Leader>qs", "<Cmd>SessionSave<CR>", { desc = "Save project session" })

			vim.keymap.set("n", "<Leader>ql", "<Cmd>SessionLoad<CR>", { desc = "Load project session" })

			vim.keymap.set("n", "<Leader>qL", "<Cmd>SessionLast<CR>", { desc = "Load last session" })

			vim.keymap.set("n", "<Leader>qd", "<Cmd>SessionDelete<CR>", { desc = "Delete project session" })
		end,
	},
	{
		"scottmckendry/pick-resession.nvim",
		dependencies = {
			"stevearc/resession.nvim",
		},
		keys = {
			{
				"<Leader>qf",
				function()
					require("pick-resession").pick({ dir = "dirsession" })
				end,
				desc = "Search session",
			},
		},
	},
}
