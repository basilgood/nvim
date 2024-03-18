return {
  'lewis6991/gitsigns.nvim',
  dependencies = {
    'tpope/vim-fugitive',
    { 'akinsho/git-conflict.nvim', opts = {} },
  },
  config = function()
    if vim.fn.executable('nvr') == 1 then
      vim.env.GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=delete'"
    end

    local gs = require('gitsigns')
    local map = vim.keymap.set
    gs.setup({
      signs = { untracked = { text = '' } },
      _signs_staged_enable = true,
      _signs_staged = {
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
        map('n', 'ghd', gs.diffthis)
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    })
  end,
}
