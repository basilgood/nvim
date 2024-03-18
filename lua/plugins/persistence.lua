return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = { options = vim.opt.sessionoptions:get() },
  keys = {
    {
      '<leader>s',
      function()
        require('persistence').load()
      end,
      desc = 'Restore Session',
    },
  },
}
