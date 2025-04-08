return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {--[[ things you want to change go here]]
      auto_scroll = true,
      autochdir = true,
      hide_numbers = true,
      start_in_insert = true,
      shade_terminals = false,
      highlights = {
        Normal = {
          guibg = '#1e1e2e',
        },
      },
    },
  },
}
