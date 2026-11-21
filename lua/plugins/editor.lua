return {
  {
    'haya14busa/vim-asterisk',
    config = function()
      -- Replaces the builtin `*` in normal and visual mode.
      vim.keymap.set({ 'n', 'x' }, '*', '<Plug>(asterisk-z*)', { desc = 'Search word under cursor (asterisk)' })
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
      { '<leader>bd', function() require('mini.bufremove').delete() end, desc = 'Delete buffer' },
      { '<leader>bw', function() require('mini.bufremove').wipeout() end, desc = 'Wipeout buffer' },
    },
  },
  {
    'smoka7/hop.nvim',
    opts = { jump_on_sole_occurrence = true, create_hl_autocmd = false, dim_unmatched = false },
    -- Overrides the builtin `s` (substitute) and `f` (find char): both are Hop jumps.
    keys = {
      { 's', '<cmd>HopChar1<cr>', desc = 'Hop to character' },
      { 'f', '<cmd>HopChar1CurrentLine<cr>', desc = 'Hop to character in line' },
    },
  },
  { 'polirritmico/simple-boolean-toggle.nvim', opts = {} },
  { 'stevearc/quicker.nvim', opts = {}, ft = 'qf' },
  {
    'ouuan/nvim-bigfile',
    opts = {},
  },
}
