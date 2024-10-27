if vim.fn.executable('nvr') == 1 then
  vim.env.GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=delete'"
end

local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

-- gitv
vim.g.Gitv_OpenPreviewOnLaunch = 0

map('n', 'ghg', '<cmd>tab G<cr>')
map('n', 'ghl', '<cmd>GV --all<cr>')
map('n', 'ghd', '<cmd>Gvdiffsplit!<cr>')
map('n', 'gh2', '<cmd>diffget //2<cr>')
map('n', 'gh3', '<cmd>diffget //3<cr>')
autocmd('filetype', {
  pattern = 'git',
  callback = function()
    local opts = { buffer = true, remap = true }
    map('n', 'ghl', 'gqghl', opts)
  end,
})

local gs = require('gitsigns')
gs.setup({
  signs = { untracked = { text = '' } },
  signs_staged_enable = true,
  signs_staged = {
    add = { text = '┋ ' },
    change = { text = '┋ ' },
    delete = { text = '﹍' },
    topdelete = { text = '﹉' },
    changedelete = { text = '┋ ' },
  },
  on_attach = function()
    map('n', '[c', gs.prev_hunk, { buffer = true })
    map('n', ']c', gs.next_hunk, { buffer = true })
    map('n', 'ghs', gs.stage_hunk)
    map('n', 'ghr', gs.reset_hunk)
    map('n', 'ghu', gs.undo_stage_hunk)
    map('n', 'ghp', gs.preview_hunk)
    map('n', 'ghB', function()
      gs.blame_line({ full = true })
    end)
    map('n', 'ghb', gs.toggle_current_line_blame)
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
})
