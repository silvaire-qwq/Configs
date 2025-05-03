return {
	"folke/which-key.nvim",
	enabled = true,
	event = "VimEnter",
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("which-key").setup({
			---@param ctx { mode: string, operator: string }
			defer = function(ctx)
				if vim.list_contains({ "d", "y" }, ctx.operator) then
					return true
				end
				return vim.list_contains({ "v", "<C-V>", "V" }, ctx.mode)
			end,
			preset = "helix",
			icons = {
				colors = true,
				keys = {
					Up = "􀄨",
					Down = "􀄩",
					Left = "􀄪",
					Right = "􀄫",
					C = "􀆍",
					M = "􀆕",
					S = "􀆝",
					CR = "􀅇",
					Esc = "􀆧",
					ScrollWheelDown = "󱕐",
					ScrollWheelUp = "󱕑",
					NL = "􀅇",
					BS = "􁂉",
					Space = "󱁐",
					Tab = "􀅂",
				},
			},
		})

		-- Document existing key chains
		require("which-key").add({
			{ "g", group = "Go to", icon = "󰿅" },
			{ "<leader>a", group = "Avante", icon = "󰚩" },
			{ "<leader>b", group = "Buffer", icon = "" },
			{ "<leader>d", group = "DAP", icon = "" },
			{ "<leader>c", group = "DiffView", icon = "" },
			{ "<leader>e", group = "Toggle Tree", icon = "" },
			{ "<leader>g", group = "Git", icon = "" },
			{ "<leader>i", group = "Toggle Boolean", icon = "" },
			{ "<leader>l", group = "Lsp", mode = "n", icon = "" },
			{ "<leader>r", group = "Overseer tasks", mode = "n", icon = "󰑮" },
			{ "<leader>f", group = "Find", mode = "n" },
			{ "<leader>w", group = "Save this file", icon = "" },
			{ "<leader>q", group = "Exit", icon = "󰿅" },
			{ "<leader>t", group = "Toggle Terminal", icon = " " },
			{ "<leader>h", group = "Git Hunk", mode = { "n", "v" } },
			{ "<leader>P", group = "Picture", icon = "" },
			{ "<leader>x", group = "Execute Lua", icon = "", mode = { "n", "v" } },
		})
	end,
}
