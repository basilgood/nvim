return {
  {
    'lewis6991/hover.nvim',
    config = function()
      require('hover').setup({
        init = function()
          require('hover.providers.lsp')
          require('hover.providers.dictionary')
        end,
      })
      vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
    end,
  },
  {
    'weilbith/nvim-code-action-menu',
    keys = {
      { '<f4>', '<cmd>CodeActionMenu<cr>' },
    },
  },
}
