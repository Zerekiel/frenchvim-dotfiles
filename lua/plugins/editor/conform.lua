return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = { "ConformInfo" },
	config = function()
		local conform = require("conform")
		local prettier = { "prettier", stop_after_first = true }
		conform.setup({
			default_format_opts = {
				lsp_format = "fallback",
			},
      format_on_save = {
        timeout_ms = 500,
      },
			formatters_by_ft = {
				c = { "clang-format" },
				cmake = { "cmake-format" },
				cpp = { "clang-format" },
				css = prettier,
				html = prettier,
				java = { "astyle" },
				javascript = prettier,
				json = prettier,
				lua = { "stylua" },
				sh = { "shfmt" },
				typescript = prettier,
				yaml = prettier,
			},
			formatters = {
				astyle = {
					command = "astyle",
					prepend_args = { "-s2", "-c", "-J", "-n", "-q", "-z2", "-xC80" },
				},
				["clang-format"] = {
					command = "clang-format",
					prepend_args = { "--style=file", "-i" },
				},
				["cmake-format"] = {
					command = "cmake-format",
					prepend_args = { "-i" },
				},
				prettier = {
					command = "prettier",
					prepend_args = { "-w" },
				},
				shfmt = {
					command = "shfmt",
					prepend_args = { "-i", "0", "-sr", "-kp" },
				},
			},
		})
	end,
	keys = {
		{
			"<leader>rf",
			function()
				require("conform").format({ async = true })
			end,
			desc = "format buffer",
		},
	},
}
