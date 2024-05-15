return {
  'lewis6991/gitsigns.nvim',
  dependencies = {
    'sindrets/diffview.nvim',
    'tpope/vim-fugitive',
    {
      'NeogitOrg/neogit',
      branch = 'nightly',
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
      opts = {},
    },
  },
  config = function()
    if vim.fn.executable('nvr') == 1 then
      vim.env.GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=delete'"
    end
    vim.g.committia_open_only_vim_starting = 0
    local map = vim.keymap.set
    local gs = require('gitsigns')
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
    map('n', 'ghg', '<cmd>tab G<cr>')
  end,
}
