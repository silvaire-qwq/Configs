local wezterm = require("wezterm")
return {
	font_size = 13,
	font = wezterm.font_with_fallback({
		{ family = "FiraCode Nerd Font", weight = "Medium" },
		{ family = "Maple Mono Featured NF CN", weight = "Medium" },
		{ family = "CaskaydiaCove Nerd Font" },
		{ family = "Apple Color Emoji" },
		-- { family = "MiSans VF", weight = "Medium" },
	}),
	font_rules = {
		{
			italic = true,
			font = wezterm.font({
				family = "VictorMono Nerd Font",
				weight = "Medium",
				style = "Italic",
			}),
		},
	},
	window_padding = {
		left = 30,
		right = 30,
		top = 30,
		bottom = 30,
	},
	line_height = 1.35,
	cell_width = 0.9,
	adjust_window_size_when_changing_font_size = false,
	enable_wayland = true,
	freetype_load_flags = "NO_HINTING|NO_AUTOHINT",
	color_scheme = "Catppuccin Mocha",
	use_fancy_tab_bar = false,
	window_decorations = "NONE",
	show_new_tab_button_in_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	enable_tab_bar = true,
}
