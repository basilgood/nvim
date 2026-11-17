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
  {
    'esmuellert/codediff.nvim',
    cmd = 'CodeDiff',
  },

  {
    'Salanoid/gitlogdiff.nvim',
    main = 'gitlogdiff',
    cmd = 'GitLogDiff',
    dependencies = { 'dlyongemallo/diffview-plus.nvim' },
    opts = { max_count = 300 },
  },
  {
    'vieitesss/minifugit.nvim',
  },
  {
    'NeogitOrg/neogit',
    lazy = true,
    dependencies = {
      'm00qek/baleia.nvim', -- optional
    },
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Show Neogit UI' },
    },
  },
  {
    'roschaefer/blame.nvim',
    opts = {},
    cmd = 'Blame',
  },
  {
    'zion-off/diff',
    config = function()
      require('diff').setup()
    end,
  },
  {
    'CoreyKaylor/diffbandit.nvim',
    cmd = {
      'DiffBandit',
      'DiffBanditBuffers',
      'DiffBanditFolderDiff',
      'DiffBanditGit',
      'DiffBanditGitCurrent',
      'DiffBanditCommitPanel',
      'DiffBanditGitMenu',
      'DiffBanditGitLog',
      'DiffBanditGitCommit',
      'DiffBanditGitCompare',
      'DiffBanditGitCheckout',
      'DiffBanditMerge',
    },
    opts = {},
  },
  -- {
  --   'SuperBo/fugit2.nvim',
  --   build = false,
  --   opts = {
  --     width = 100,
  --   },
  --   config = function(_, opts)
  --     require('fugit2').setup(opts)

  --     local GitDiff = require('fugit2.view.git_diff')
  --     GitDiff._index_add_reset_handler = function(self, _, action)
  --       return function()
  --         self:_index_add_reset_discard(action)
  --       end
  --     end

  --     require('nui.utils.autocmd').event.BufModifiedSet = 'OptionSet'
  --   end,
  --   dependencies = {
  --     'MunifTanjim/nui.nvim',
  --     'nvim-tree/nvim-web-devicons',
  --     'nvim-lua/plenary.nvim',
  --     {
  --       'chrisgrieser/nvim-tinygit',
  --       dependencies = { 'stevearc/dressing.nvim' },
  --     },
  --   },
  --   cmd = { 'Fugit2', 'Fugit2Diff', 'Fugit2Graph', 'Fugit2Rebase' },
  --   keys = {
  --     { '<leader>gg', mode = 'n', '<cmd>Fugit2<cr>' },
  --   },
  -- },
}
