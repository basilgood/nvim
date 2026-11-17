return {
  -- {
  --   'folke/snacks.nvim',
  --   opts = {
  --     bigfile = { enabled = true },
  --     quickfile = { enabled = true },
  --     indent = {
  --       enabled = true,
  --       indent = { enabled = false },
  --       scope = { enabled = false },
  --       chunk = { enabled = true },
  --     },
  --     gh = { enabled = true },
  --     picker = {
  --       enabled = true,
  --       ui_select = true,
  --       layout = { cycle = false },
  --     },
  --     image = {
  --       backend = 'kitty',
  --       inline = false,
  --       doc = {
  --         enabled = true,
  --         inline = false,
  --         float = true,
  --         max_width = 80,
  --         max_height = 40,
  --       },
  --     },
  --     input = { enabled = true },
  --   },
  --   -- stylua: ignore
  --   keys = {
  --     { '<c-p>', function() Snacks.picker.files({ hidden = true }) end },
  --     { '<bs>', function() Snacks.picker.buffers({ current = false }) end },
  --     { '<leader>/', function() Snacks.picker.grep({ hidden = true }) end },
  --     { '<leader>rr', function() Snacks.picker.resume() end },
  --     { '<leader>u', function() Snacks.picker.undo() end },
  --     { 'z=', function() Snacks.picker.spelling() end },
  --     { '<leader>gg', function() Snacks.lazygit() end },
  --     { '<f1>', function() Snacks.terminal.toggle() end, mode = { 'n', 't' } },
  --     { '<leader>.', function() Snacks.scratch() end },
  --     { '<leader>S', function() Snacks.scratch.select() end },
  --     { '<leader>bd', function() Snacks.bufdelete() end },
  --     { '<leader>l', function() Snacks.picker() end },
  --   },
  -- },
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
