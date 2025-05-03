function _G.get_oil_winbar()
  local dir = require('oil').get_current_dir()
  if dir then
    return vim.fn.fnamemodify(dir, ':~')
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end
local detail = false
-- helper function to parse output
local function parse_output(proc)
  local result = proc:wait()
  local ret = {}
  if result.code == 0 then
    for line in vim.gsplit(result.stdout, '\n', { plain = true, trimempty = true }) do
      -- Remove trailing slash
      line = line:gsub('/$', '')
      ret[line] = true
    end
  end
  return ret
end

require('oil').setup {
  default_file_explorer = true,
  keymaps = {
    ['<C-h>'] = false,
    ['<C-l>'] = false,
    ['<C-k>'] = false,
    ['<C-j>'] = false,
    ['<C-r>'] = 'actions.refresh',
    ['g.'] = false,
    ['zh'] = 'actions.toggle_hidden',
    ['\\'] = { 'actions.select', opts = { horizontal = true } },
    ['|'] = { 'actions.select', opts = { vertical = true } },
    ['-'] = 'actions.close',
    ['<leader>e'] = 'actions.close',
    ['<BS>'] = 'actions.parent',
    ['gd'] = {
      desc = 'Toggle file detail view',
      callback = function()
        detail = not detail
        if detail then
          require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
        else
          require('oil').set_columns { 'icon' }
        end
      end,
    },
  },
  win_options = {
    winbar = '%!v:lua.get_oil_winbar()',
  },
}
