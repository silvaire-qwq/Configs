require("blink.cmp").setup({
	keymap = {
		preset = "super-tab",
	},
	sources = {
		default = { "snippets", "lsp", "path", "buffer" },
		providers = {
			snippets = { score_offset = 1000 },
		},
	},
	cmdline = {
		completion = {
			menu = {
				auto_show = true,
			},
		},
	},
	completion = {
		keyword = {
			range = "full",
		},
		menu = {
			border = "rounded",
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon" }, { "label", gap = 1 } },
				components = {
					kind_icon = {
						ellipsis = false,
						text = function(ctx)
							local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
							return kind_icon
						end,
						-- Optionally, you may also use the highlights from mini.icons
						highlight = function(ctx)
							local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
							return hl
						end,
					},
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
			scrollbar = false,
		},
		documentation = {
			window = { border = "single", scrollbar = false },
			auto_show = true,
			auto_show_delay_ms = 500,
		},
		-- list = {
		-- selection = {
		-- preselect = false,
		-- },
		-- },
	},
	signature = {
		enabled = true,
		window = { border = "single" },
	},
	appearance = {
		nerd_font_variant = "normal",
	},
})
