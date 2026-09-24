local keymap = vim.keymap -- for conciseness
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function()
		-- set keybinds

		-- Navigation

		keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Show LSP definition" })
		keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
		keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Show LSP implementations" })
		keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Show LSP type definitions" })
		keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor" })

		-- Actions
		keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "See available code actions" })
		keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "Smart rename" })

		-- Diagnostic
		keymap.set("n", "<leader>dD", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" })
		keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

		-- Diagnostic Navigation
		keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, { desc = "Go to previous diagnostic" })

		keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, { desc = "Go to next diagnostic" })

		-- LSP actions
		keymap.set("n", "<leader>ls", ":Lsp restart<CR>", { desc = "Restart LSP" })
	end,
})

-- vim.lsp.inlay_hint.enable(true)

local severity = vim.diagnostic.severity
local icons = require("core.icons")

vim.diagnostic.config({
	signs = {
		text = {
			[severity.ERROR] = icons.diagnostic.error,
			[severity.WARN] = icons.diagnostic.warn,
			[severity.HINT] = icons.diagnostic.hint,
			[severity.INFO] = icons.diagnostic.info,
		},
	},
})
