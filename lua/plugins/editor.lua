return {
  {
    'haya14busa/vim-asterisk',
    config = function()
      vim.keymap.set({ 'n', 'x' }, '*', '<Plug>(asterisk-z*)')
    end,
  },
  { 'numToStr/Comment.nvim', opts = { ignore = '^%s*$' } },
  { 'kylechui/nvim-surround', opts = {} },
  { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {} },
  { 'windwp/nvim-ts-autotag', opts = {} },
  {
    'nvim-mini/mini.bufremove',
    opts = {},
    -- stylua: ignore
    keys = {
      { '<leader>bd', function() require('mini.bufremove').delete() end, },
      { '<leader>bw', function() require('mini.bufremove').wipeout() end, },
    },
  },
  {
    'smoka7/hop.nvim',
    opts = { jump_on_sole_occurrence = true, create_hl_autocmd = false, dim_unmatched = false },
    keys = { { 's', '<cmd>HopChar1<cr>' }, { 'f', '<cmd>HopChar1CurrentLine<cr>' } },
  },
  { 'polirritmico/simple-boolean-toggle.nvim', opts = {} },
  { 'stevearc/quicker.nvim', opts = {}, ft = 'qf' },
  {
    'ouuan/nvim-bigfile',
    opts = {},
  },
}
