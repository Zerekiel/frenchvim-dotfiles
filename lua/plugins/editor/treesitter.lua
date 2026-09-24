return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",

		config = function()
			local TS = require("nvim-treesitter")

			TS.setup()

			TS.install({
				"tsx",
				"typescript",
				"javascript",
				"html",
				"css",
				"vue",
				"gitcommit",
				"json",
				"json5",
				"lua",
				"markdown",
				"vim",
				"c",
				"bash",
				"jsdoc",
				"python",
				"regex",
				"xml",
				"yaml",
				"java",
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"c",
					"cpp",
					"css",
					"html",
					"java",
					"javascript",
					"javascriptreact",
					"json",
					"lua",
					"markdown",
					"python",
					"tsx",
					"typescript",
					"typescriptreact",
					"vue",
					"yaml",
				},
				callback = function(args)
					local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)

					if not lang then
						return
					end

					vim.treesitter.start(args.buf, lang)

					vim.wo.foldmethod = "expr"
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				end,
			})

			vim.filetype.add({
				extension = {
					mdx = "mdx",
				},
			})

			vim.treesitter.language.register("markdown", "mdx")
		end,
	},
}
