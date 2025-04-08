local function getLen(str, start_pos)
	local byte = string.byte(str, start_pos)
	if not byte then
		return nil
	end

	return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
end

local function colorize(header, header_color_map, colors)
	for letter, color in pairs(colors) do
		local color_name = "AlphaJemuelKwelKwelWalangTatay" .. letter
		vim.api.nvim_set_hl(0, color_name, color)
		colors[letter] = color_name
	end

	local colorized = {}

	for i, line in ipairs(header_color_map) do
		local colorized_line = {}
		local pos = 0

		for j = 1, #line do
			local start = pos
			pos = pos + getLen(header[i], start + 1)

			local color_name = colors[line:sub(j, j)]
			if color_name then
				table.insert(colorized_line, { color_name, start, pos })
			end
		end

		table.insert(colorized, colorized_line)
	end

	return colorized
end

-- local ascii_arts = require("custom.ui.ascii_arts")
return {
	"goolord/alpha-nvim",
	config = function()
		local alpha = require("alpha")

		local mocha = require("catppuccin.palettes").get_palette("mocha")

		local dashboard = require("alpha.themes.dashboard")

		local header = {
			[[    ███╗   ███╗ █████╗ ██╗  ██╗███████╗   ]],
			[[    ████╗ ████║██╔══██╗██║ ██╔╝██╔════╝   ]],
			[[    ██╔████╔██║███████║█████╔╝ █████╗     ]],
			[[    ██║╚██╔╝██║██╔══██║██╔═██╗ ██╔══╝     ]],
			[[    ██║ ╚═╝ ██║██║  ██║██║  ██╗███████╗   ]],
			[[    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ]],
			[[███████╗████████╗██╗   ██╗███████╗███████╗]],
			[[██╔════╝╚══██╔══╝██║   ██║██╔════╝██╔════╝]],
			[[███████╗   ██║   ██║   ██║█████╗  █████╗  ]],
			[[╚════██║   ██║   ██║   ██║██╔══╝  ██╔══╝  ]],
			[[███████║   ██║   ╚██████╔╝██║     ██║     ]],
			[[╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝     ]],
		}

		local color_map = {
			[[    VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV   ]],
			[[    VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV   ]],
			[[    VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV     ]],
			[[    VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV     ]],
			[[    VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV   ]],
			[[    VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV   ]],
			[[VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV]],
			[[VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV]],
			[[VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV  ]],
			[[VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV  ]],
			[[VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV     ]],
			[[VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV     ]],
		}

		local colors = {
			--["W"] = { fg = mocha.base },
			--["C"] = { fg = mocha.text },
			--["B"] = { fg = mocha.crust },
			--["R"] = { fg = mocha.red },
			--["O"] = { fg = mocha.peach },
			--["Y"] = { fg = mocha.yellow },
			--["G"] = { fg = mocha.green },
			--["U"] = { fg = mocha.blue },
			--["P"] = { fg = mocha.yellow },
			--["H"] = { fg = mocha.pink },
			--["F"] = { fg = mocha.red },
			--["M"] = { fg = mocha.overlay0 },
			["V"] = { fg = mocha.lavender },
		}

		dashboard.section.header.val = header
		dashboard.section.header.opts = {
			hl = colorize(header, color_map, colors),
			position = "center",
		}

		dashboard.section.buttons.val = {
			dashboard.button("n", "  New file", "<Cmd>ene <CR>"),
			dashboard.button("m", "  Mason Dashboard", "<Cmd>Mason<CR>"),
			dashboard.button("l", "  Lazy Dashboard", "<Cmd>Lazy<CR>"),
			dashboard.button("c", "  Config", "<Cmd>Neotree reveal ~/.config/nvim<CR>"),
			dashboard.button("q", "󰿅  Exit", "<Cmd>qa<CR>"),
		}
		for _, a in ipairs(dashboard.section.buttons.val) do
			a.opts.width = 49
			a.opts.cursor = -2
		end

		alpha.setup(dashboard.config)
	end,
}
