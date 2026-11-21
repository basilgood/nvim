return {
  {
    'ibhagwan/fzf-lua',
    config = function()
      require('fzf-lua').setup({
        keymap = {
          fzf = {
            ['ctrl-q'] = 'select-all+accept',
          },
        },
        defaults = {
          file_icons = 'devicons',
        },
        winopts = {
          border = 'single',
          preview = {
            border = 'single',
            scrollbar = false,
          },
        },
        hls = {
          backdrop = 'FloatBorder',
        },
      })

      vim.keymap.set('n', '<c-p>', '<cmd>FzfLua files<CR>', { desc = 'Find files' })
      vim.keymap.set('n', '<leader>/', '<cmd>FzfLua live_grep<CR>', { desc = 'Grep live' })
      vim.keymap.set('n', '<bs>', '<cmd>FzfLua buffers<CR>', { desc = 'Find buffers' })
      vim.keymap.set('n', '<leader>l', '<cmd>FzfLua<CR>', { desc = 'FzfLua' })
    end,
  },
  {
    'otavioschwanck/fzf-lua-explorer.nvim',
    keys = {
      { '<leader>f', "<cmd>lua require('fzf-lua-explorer').explorer()<cr>", desc = 'Explorer' },
    },
    config = function()
      require('fzf-lua-explorer').setup()
    end,
  },
}
