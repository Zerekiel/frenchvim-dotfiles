return {
	{
		"folke/todo-comments.nvim",
		lazy = false,
		opts = {
			signs = true,
			sign_priority = 8,

			keywords = {
				FIX = {
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
				},
				WARN = { alt = { "WARNING" } },
				PERF = { alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			},
			highlight = {
				before = "", -- "fg" or "bg" or empty
				keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
				after = "fg", -- "fg" or "bg" or empty
				pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
				comments_only = true, -- uses treesitter to match keywords in comments only
				max_line_len = 400, -- ignore lines longer than this
				exclude = {}, -- list of file types to exclude highlighting
			},
		},
		keys = {
			{
				"<leader>ct",
				function()
					Snacks.picker.todo_comments()
				end,
				desc = "Todo",
			},
			{
				"<leader>cT",
				function()
					Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
				end,
				desc = "Todo/Fix/Fixme",
			},
			{
				"ctn",
				function()
					require("todo-comments").jump_next()
				end,
				mode = "n",
				desc = "Next todo comment",
			},
			{
				"ctp",
				function()
					require("todo-comments").jump_prev()
				end,
				mode = "n",
				desc = "Previous todo comment",
			},
		},
	},
}
