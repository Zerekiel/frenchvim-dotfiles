local g = vim.g
local keymap = vim.keymap

g.mapleader = " "

-- window managment
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- save and exit quickly
keymap.set("n", "<leader>w", ":w<Enter>", { silent = true, desc = "Quick save" })
keymap.set("n", "<leader>Q", "<cmd>qa<CR>", { silent = true, desc = "Close Nvim" })

-- Git Blame
keymap.set("n", "<leader>gb", ":BlameToggle<Enter>", { silent = true, desc = "Git Blame" })

-- Persistence :
keymap.set("n", "<leader>qs", function()
	require("persistence").load()
end, { silent = true, desc = "Load current directory session" })
keymap.set("n", "<leader>qS", function()
	require("persistence").select()
end, { silent = true, desc = "Select a session to load" })
keymap.set("n", "<leader>ql", function()
	require("persistence").load({ last = true })
end, { silent = true, desc = "Load last session" })
keymap.set("n", "<leader>qd", function()
	require("persistence").stop()
end, { silent = true, desc = "Session won't be saved on exit" })

-- Substitute NOHL
keymap.set("c", "<Esc>", function()
	local mode = vim.fn.getcmdtype()
	if mode == "/" or mode == "?" then
		vim.cmd("nohlsearch")
		return "<C-c>"
	end
	return "<Esc>"
end, { expr = true })

keymap.set("n", "<ESC>", function()
	if vim.v.hlsearch == 1 then
		vim.cmd("nohlsearch")
	end
	return "<ESC>"
end)
