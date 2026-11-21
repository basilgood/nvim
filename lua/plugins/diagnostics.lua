-- Diagnostic display options shared by every buffer. Kept here, above the
-- specs, because this is the file to open when looking for diagnostic settings.
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

return {
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    config = function()
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
        desc = 'Next diagnostic (Trouble)',
      },
      {
        ']t',
        function()
          require('trouble').prev({ skip_groups = true, jump = true })
        end,
        desc = 'Previous diagnostic (Trouble)',
      },
    },
  },
}
