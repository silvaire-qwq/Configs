return {
	"yetone/avante.nvim",
	cmd = { "AvanteChat", "AvanteAsk" },
	keys = { "<leader>aa", "<leader>af" },
	version = "*",
	opts = {
		provider = "openrouter",
		vendors = {
			openrouter = {
				__inherited_from = "openai",
				disable_tools = true,
				endpoint = "https://openrouter.ai/api/v1",
				api_key_name = "OPENROUTER_API_KEY",
				model = "deepseek/deepseek-chat-v3-0324:free",
			},
		},
		-- file_selector = { provider = "snacks" },
	},
	build = "make",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- 'MunifTanjim/nui.nvim',
		"zbirenbaum/copilot.lua",
		"echasnovski/mini.nvim",
		"MeanderingProgrammer/render-markdown.nvim",
	},
}
