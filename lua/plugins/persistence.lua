return {
  'folke/persistence.nvim',
  opts = {},
  event = 'BufReadPre',
    -- stylua: ignore
  keys = {
    { '<leader>ss', function() require('persistence').load() end, desc = 'Restore Session' },
  },
}
