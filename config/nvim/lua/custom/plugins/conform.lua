return {
	"stevearc/conform.nvim",
	init = function()
		vim.g.disable_autoformat = false
	end,
	event = { "BufWritePre", "InsertEnter" },
	cmd = { "ConformInfo", "FormatEnable", "FormatDisable" },
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			desc = "Format buffer",
		},
	},
	config = function()
		require("custom.config.conform")
	end,
}
