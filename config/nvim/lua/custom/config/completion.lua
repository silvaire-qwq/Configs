require("blink.cmp").setup({
	sources = {
		-- default = { 'lsp', 'path', 'snippets', 'buffer' },
		providers = {
			snippets = { score_offset = 1000 },
		},
	},
	signature = {
		window = { border = "single" },
	},
	cmdline = {
		completion = {
			menu = {
				auto_show = true,
			},
		},
	},
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
		},
		list = {
			selection = {
				preselect = false,
			},
		},
		menu = {
			border = "single",
			draw = {
				columns = { { "kind_icon" }, { "label", gap = 1 } },
				components = {
					label = {
						text = function(ctx)
							return require("colorful-menu").blink_components_text(ctx)
						end,
						highlight = function(ctx)
							return require("colorful-menu").blink_components_highlight(ctx)
						end,
					},
				},
			},
		},
		documentation = {
			window = { border = "single" },
			auto_show = true,
			auto_show_delay_ms = 500,
		},
	},
	keymap = {
		preset = "super-tab",
	},
})
