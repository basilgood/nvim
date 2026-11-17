return {
  'WorksOnMyVM/herdr-agent-bridge.nvim',
  main = 'herdr_agent',
  lazy = false,
  opts = {
    context = { provider = 'auto' },
    pane = { size = 0.30 },
    agent = {
      kind = 'claude',
      name = nil,
    },
    keymaps = {
      toggle = '<leader>aa',
      -- open = "<leader>ao", -- optional: always reveal and focus the agent
      send_this = '<leader>at',
      send_file = '<leader>af',
      send_selection = '<leader>av',
      prompt = '<leader>ap',
    },
  },
}
