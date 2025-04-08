return {
	"nat-418/boole.nvim",
	opts = {
		mappings = {
			increment = "<leader>i",
		},
		-- User defined loops
		additions = {
			{ "Foo", "Bar" },
			{ "tic", "tac", "toe" },
		},
		allow_caps_additions = {
			{ "enable", "disable" },
			-- enable → disable
			-- Enable → Disable
			-- ENABLE → DISABLE
		},
	},
}
