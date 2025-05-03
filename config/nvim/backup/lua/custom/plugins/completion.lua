return {
	{
		"saghen/blink.cmp",
		-- build = 'cargo build --release',
		version = "1.*",
		dependencies = {
			{
				"xzbdmw/colorful-menu.nvim",
				config = function()
					require("custom.config.colorful-menu")
				end,
			},
		},
		-- event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("custom.config.completion")
		end,
	},
	{ "rafamadriz/friendly-snippets", ft = { "tex" } },
}
