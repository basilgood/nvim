return {
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    config = function()
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '✗',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.INFO] = '∙',
            [vim.diagnostic.severity.HINT] = '∴',
          },
        },
        underline = false,
        virtual_text = false,
      })

      require('tiny-inline-diagnostic').setup({
        options = {
          show_source = {
            enabled = true,
            if_many = true,
          },
        },
      })
    end,
  },
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '[t',
        function()
          require('trouble').next({ skip_groups = true, jump = true })
        end,
      },
      {
        ']t',
        function()
          require('trouble').prev({ skip_groups = true, jump = true })
        end,
      },
    },
  },
}
