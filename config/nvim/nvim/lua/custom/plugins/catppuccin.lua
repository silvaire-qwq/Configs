return {
	"catppuccin/nvim",
	priority = 1000, -- Make sure to load this before all the other start plugins.
	init = function()
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
	config = function()
		require("catppuccin").setup({
			flavour = "auto", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { "italic" }, -- Change the style of comments
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = { "bold" },
				properties = {},
				types = {
					"bold",
				},
				operators = {},
				-- miscs = {}, -- Uncomment to turn off hard-coded styles
			},
			transparent_background = false,
			term_colors = true,
			integrations = {
				aerial = true,
				blink_cmp = true,
				cmp = true,
				diffview = true,
				mini = {
					enabled = true,
					indentscope_color = "lavender",
				},
				fzf = true,
				noice = true,
				-- overseer = true,
				telescope = {
					enabled = true,
					-- style = "nvchad",
				},
				indent_blankline = {
					enabled = true,
					scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
					colored_indent_levels = false,
				},
				neotree = false,
				which_key = true,
				treesitter = true,
				mason = true,
				notify = true,
				rainbow_delimiters = true,
				snacks = true,
			},
		})
	end,
}
