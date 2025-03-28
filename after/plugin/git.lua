local map = vim.keymap.set
local gs = require('gitsigns')
gs.setup({
  signs = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '▎' },
    topdelete = { text = '▎' },
    changedelete = { text = '▎' },
    untracked = { text = '▎' },
  },
  signs_staged_enable = true,
  on_attach = function()
    map('n', '[c', gs.prev_hunk, { buffer = true })
    map('n', ']c', gs.next_hunk, { buffer = true })
    map('n', 'ghr', gs.reset_hunk)
    map('n', 'ghp', gs.preview_hunk)
    map('n', 'ghB', function()
      gs.blame_line({ full = true })
    end)
    map('n', 'ghb', gs.toggle_current_line_blame)
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
})
map('n', 'ghg', '<cmd>tab G<cr>')
map('n', 'ghd', '<cmd>Gvdiffsplit!<cr>')
map('n', 'ghl', '<cmd>GV --all<cr>')
map('n', 'ght', '<cmd>GV --no-graph --no-walk --tags<cr>')
