return {
	"folke/noice.nvim",
	event = "VeryLazy",

	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},

	opts = {
		-- Intégration avec le LSP et nvim-cmp
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},

		-- Commandes : :Telescope, :e, :w, etc.
		cmdline = {
			enabled = true,
			view = "cmdline_popup",
		},

		-- Messages / notifications
		messages = {
			enabled = true,
			view = "notify",
			view_error = "notify",
			view_warn = "notify",
			view_history = "messages",
			view_search = "virtualtext",
		},

		-- Popup de completion
		popupmenu = {
			enabled = true,
			backend = "nui",
		},

		-- Presets
		presets = {
			-- / et ? restent en bas
			bottom_search = false,

			-- :commands apparaissent dans une popup
			command_palette = true,

			-- Les longs messages vont dans un split
			long_message_to_split = true,

			-- Pas besoin pour l'instant
			inc_rename = false,

			-- Bordure autour des fenêtres de documentation LSP
			lsp_doc_border = true,
		},
	},

	config = function(_, opts)
		local noice = require("noice")

		noice.setup(opts)

		-- Historique des messages Noice
		vim.keymap.set("n", "<leader>nh", "<cmd>Noice history<cr>", {
			desc = "Noice history",
		})

		-- Dernier message
		vim.keymap.set("n", "<leader>nl", "<cmd>Noice last<cr>", {
			desc = "Noice last message",
		})

		-- Erreurs
		vim.keymap.set("n", "<leader>ne", "<cmd>Noice errors<cr>", {
			desc = "Noice errors",
		})
	end,
}
