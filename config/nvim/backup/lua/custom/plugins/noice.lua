return {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
	config = function()
		require("noice").setup({
			cmdline = {
				enabled = true, -- enables the Noice cmdline UI
				view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
				opts = {}, -- global options for the cmdline. See section on views
				---@type table<string, CmdlineFormat>
				format = {
					-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
					-- view: (default is cmdline view)
					-- opts: any options passed to the view
					-- icon_hl_group: optional hl_group for the icon
					-- title: set to anything or empty string to hide
					cmdline = { pattern = "^:", icon = "󰘳 ", lang = "vim" },
					search_down = { kind = "search", pattern = "^/", icon = "", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = "", lang = "regex" },
					filter = { pattern = "^:%s*!", icon = " ", lang = "bash" },
					lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
					help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
					input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
					-- lua = false, -- to disable a format, set to `false`
				},
			},
			lsp = {
				progress = {
					enabled = false,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
			messages = {
				enabled = true,
				view = "notify",
				view_error = false,
				view_warn = "notify",
				view_history = "messages",
				view_search = "virtualtext",
			},
			health = {
				checker = false,
			},
		})
	end,
}
