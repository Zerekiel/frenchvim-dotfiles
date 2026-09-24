local lazypath = vim.fn.stdpath("config") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		--{ import = "plugins" },
		{ import = "plugins.themes" },
		{ import = "plugins.display" },
		{ import = "plugins.editor" },
		{ import = "plugins.roaming" },
		{ import = "plugins.qol" },
		{ import = "plugins.lsp" },
		{ import = "plugins.git" },
		{ import = "plugins.langage" },
		{ import = "plugins.terminal" },
	},
	defaults = { lazy = false },
	install = { colorscheme = { "ayu" } },
	checker = { enabled = true },
	ui = {
		backdrop = 100,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"tarPlugin",
				"tutor",
				"zipPlugin",
			},
		},
	},
	debug = false,
})

--vim.keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>")
