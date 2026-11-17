return {
  'reybits/scratch.nvim',
  lazy = true,
  keys = {
    { '<leader>sb', '<cmd>ScratchToggle<cr>', desc = 'Toggle Buffer' },
    { '<leader>si', '<cmd>ScratchIssues<cr>', desc = 'Toggle Issues' },
    { '<leader>st', '<cmd>ScratchTask<cr>', desc = 'Add Task' },
  },
  cmd = {
    'ScratchToggle',
    'ScratchIssues',
    'ScratchTask',
  },
  opts = {
    width = 0.8,
    height = 0.8,
  },
}
