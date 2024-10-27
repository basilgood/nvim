-- init.lua
vim.loader.enable()
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

local map = vim.keymap.set
local vimRc = vim.api.nvim_create_augroup('vimRc', { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- colorscheme
vim.cmd.colorscheme('porcelain')

-- lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  local repo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', repo, '--branch=stable', lazypath })
end

vim.opt.rtp:prepend(lazypath)

-- plugins
require('lazy').setup({
  -- user preferences
  { 'basilgood/nvim-sensible', priority = 1001, opts = {} },
  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'molecule-man/telescope-menufacture',
      -- 'nvim-telescope/telescope-ui-select.nvim',
    },
  },
  -- statusline
  { 'ojroques/nvim-hardline' },
  -- tabline
  { 'seblj/nvim-tabline', dependencies = { 'nvim-tree/nvim-web-devicons' } },
  -- treesitter
  { 'nvim-treesitter/nvim-treesitter', dependencies = { 'yioneko/nvim-yati' } },
  -- completion
  -- { 'saghen/blink.cmp', event = { 'LspAttach', 'InsertCharPre' }, version = 'v0.*' },
  -- cmp
  {
    'iguanacucumber/magazine.nvim',
    name = 'nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'dcampos/cmp-snippy',
      'dcampos/nvim-snippy',
      'onsails/lspkind-nvim',
    },
  },
  -- lsp
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'marilari88/twoslash-queries.nvim', opts = { highlight = 'Comment', multi_line = true } },
      'saecki/live-rename.nvim',
      'dgagn/diagflow.nvim',
      { 'aznhe21/actions-preview.nvim', dependencies = { 'MunifTanjim/nui.nvim' } },
      { 'j-hui/fidget.nvim', opts = { progress = { ignore_empty_message = false } } },
    },
  },
  -- trouble
  { 'folke/trouble.nvim' },
  -- formatter
  { 'stevearc/conform.nvim' },
  -- linter
  { 'mfussenegger/nvim-lint' },
  -- git
  {
    'tpope/vim-fugitive',
    dependencies = {
      'junegunn/gv.vim',
      'lewis6991/gitsigns.nvim',
      { 'fredeeb/tardis.nvim', opts = {}, dependencies = 'nvim-lua/plenary.nvim' },
    },
  },
  -- notes
  {
    'renerocksai/telekasten.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-telekasten/calendar-vim' },
    opts = { home = vim.fn.expand('~/Notes'), auto_set_filetype = false },
    keys = { { '<leader>z', '<cmd>Telekasten panel<CR>' } },
    cmd = 'Telekasten',
  },
  -- markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    name = 'render-markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = ':call mkdp#util#install()',
  },
  -- misc
  { 'akinsho/toggleterm.nvim', opts = { open_mapping = '<c-t>' } },
  {
    'LunarVim/bigfile.nvim',
    'echasnovski/mini.bufremove',
    'tpope/vim-repeat',
    'kkoomen/gfi.vim',
    'loqusion/star.nvim',
  },
  { 'nvim-pack/nvim-spectre', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'smoka7/hop.nvim' },
  { 'kylechui/nvim-surround', opts = {} },
  { 'numToStr/Comment.nvim', opts = { ignore = '^$' } },
  { 'folke/ts-comments.nvim', opts = {} },
  { 'nat-418/boole.nvim', opts = { mappings = { increment = '<C-a>', decrement = '<C-x>' } } },
  { 'nvimdev/hlsearch.nvim', opts = {} },
  -- sessions
  { 'folke/persistence.nvim' },
})
