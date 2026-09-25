local keymap = vim.keymap -- for conciseness

local function goto_definition()
	local clients = vim.lsp.get_clients({ bufnr = 0 })

	if #clients == 0 then
		return
	end

	local client = clients[1]
	local encoding = client.offset_encoding or "utf-8"

	local params = vim.lsp.util.make_position_params(0, encoding)

	vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result)
		if err then
			vim.notify("LSP definition error: " .. err.message, vim.log.levels.ERROR)
			return
		end

		if not result or vim.tbl_isempty(result) then
			return
		end

		-- Transforme les Location / LocationLink du LSP
		-- en items utilisables par Neovim.
		local locations = vim.lsp.util.locations_to_items(result, encoding)

		if #locations == 0 then
			return
		end

		-- Premier résultat, comme gd normalement.
		local location = locations[1]
		local target_file = vim.fn.fnamemodify(location.filename, ":p")

		-- Cherche si le fichier est déjà affiché dans une fenêtre.
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local buf = vim.api.nvim_win_get_buf(win)
			local buf_file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":p")

			if buf_file == target_file then
				vim.api.nvim_set_current_win(win)

				vim.api.nvim_win_set_cursor(win, {
					location.lnum,
					math.max(location.col - 1, 0),
				})

				return
			end
		end

		-- Aucun split ne contient le fichier :
		-- utilise l'API moderne de Neovim.
		vim.lsp.util.show_document(result[1], encoding, {
			focus = true,
		})
	end)
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function()
		-- set keybinds

		-- Navigation

		--keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Show LSP definition" })
		keymap.set("n", "gd", goto_definition, { desc = "Show LSP definition" })
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
