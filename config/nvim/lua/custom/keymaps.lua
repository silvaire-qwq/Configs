local custom_pickers = require("custom.pickers")
vim.keymap.set("i", "jk", "<esc>", { noremap = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Move cursor down" })
vim.keymap.set("x", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Move cursor down" })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move cursor up" })
vim.keymap.set("x", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move cursor up" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "\\", "<CMD>:sp<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "|", "<CMD>:vsp<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Go to next qf item" })
vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "Go to prev qf item" })
vim.keymap.set("n", "<C-d>", "5j", { desc = "Scroll down by 5 lines" })
vim.keymap.set("n", "<C-u>", "5k", { desc = "Scroll up by 5 lines" })
vim.keymap.set("n", "L", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
vim.keymap.set("n", "H", "<cmd>bprev<cr>", { desc = "Go to prev buffer" })
vim.keymap.set("n", "+", "<C-w>|<C-w>_", { desc = "Maximize nvim pane" })
vim.keymap.set("n", "=", "<C-w>=", { desc = "Restore nvim panes" })
vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Move focus to the left window" })
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Move focus to the lower window" })
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Move focus to the upper window" })
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Move focus to the right window" })
vim.keymap.set("v", "p", '"_dP', { noremap = true })
vim.keymap.set("v", "<leader>p", "p", { noremap = true })
vim.keymap.set("n", "<space>X", "<cmd>source %<cr>", { desc = "Run this lua file" })
vim.keymap.set("n", "<space>x", ":.lua<cr>", { desc = "Run this line" })
vim.keymap.set("v", "<space>x", ":lua<cr>", { desc = "Run selection" })
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })

-- Editor
vim.keymap.set("n", "<space>w", "<CMD>:w!<cr>", { desc = "Save this file" })
vim.keymap.set("n", "<space>q", "<CMD>:q!<cr>", { desc = "Exit" })

local feedkeys = vim.api.nvim_feedkeys

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.keymap.set("n", "gx", function()
			local line = vim.fn.getline(".")
			local cursor_col = vim.fn.col(".")
			local pos = 1
			while pos <= #line do
				local open_bracket = line:find("%[", pos)
				if not open_bracket then
					break
				end
				local close_bracket = line:find("%]", open_bracket + 1)
				if not close_bracket then
					break
				end
				local open_paren = line:find("%(", close_bracket + 1)
				if not open_paren then
					break
				end
				local close_paren = line:find("%)", open_paren + 1)
				if not close_paren then
					break
				end
				if
					(cursor_col >= open_bracket and cursor_col <= close_bracket)
					or (cursor_col >= open_paren and cursor_col <= close_paren)
				then
					local url = line:sub(open_paren + 1, close_paren - 1)
					vim.ui.open(url)
					return
				end
				pos = close_paren + 1
			end
			vim.cmd("normal! gx")
		end, { buffer = true, desc = "URL opener for markdown" })
	end,
})
