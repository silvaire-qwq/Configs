return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			signs = {
				delete = { text = "_" },
				topdelete = { text = "‾" },
			},
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]h", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Jump to next git [h]unk" })

				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[h", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Jump to previous git [h]unk" })

				-- Actions
				map("v", "<leader>gs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "stage git hunk" })
				map("v", "<leader>gr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "reset git hunk" })
				-- normal mode
				map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "git toggle stage hunk" })
				map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "git reset hunk" })
				map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "git stage buffer" })
				map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "git reset buffer" })
				map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "git preview hunk" })
				map("n", "<leader>gd", gitsigns.diffthis, { desc = "git diff against index" })
				map("n", "<leader>gD", function()
					gitsigns.diffthis("@")
				end, { desc = "git [D]iff against last commit" })
			end,
		},
	},
}
