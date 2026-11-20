return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '┊' },
        change = { text = '┊' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '┊' },
        untracked = { text = '┆' },
      },
      signs_staged_enable = false,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        vim.keymap.set('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gs.nav_hunk('next')
          end
        end, { buffer = buffer })
        vim.keymap.set('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gs.nav_hunk('prev')
          end
        end, { buffer = buffer })
        vim.keymap.set('n', ']H', function()
          gs.nav_hunk('last')
        end, { buffer = buffer })
        vim.keymap.set('n', '[H', function()
          gs.nav_hunk('first')
        end, { buffer = buffer })
        vim.keymap.set('n', 'ghp', gs.preview_hunk, { buffer = buffer })
        vim.keymap.set('n', 'ghP', gs.preview_hunk_inline, { buffer = buffer })
        vim.keymap.set('n', 'ghr', gs.reset_hunk, { buffer = buffer })
        vim.keymap.set('n', 'ghb', gs.toggle_current_line_blame, { buffer = buffer })
        vim.keymap.set('n', 'ghB', function()
          gs.blame()
        end, { buffer = buffer })
        vim.keymap.set('n', 'ghd', gs.diffthis, { buffer = buffer })
        vim.keymap.set('n', 'ghD', function()
          gs.diffthis('~')
        end, { buffer = buffer })
        vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { buffer = buffer })
      end,
    },
  },

  { 'tpope/vim-fugitive' },

  {
    'dlyongemallo/diffview-plus.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
  },
}
