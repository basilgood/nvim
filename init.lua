-- init.lua
vim.loader.enable()

local g = vim.g
g.mapleader = ' '
g.have_nerd_font = true
vim.g.loaded_matchparen = 1

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  local repo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', repo, '--branch=stable', lazypath })
end

vim.opt.rtp:prepend(lazypath)

-- plugins
require('lazy').setup({
  { 'basilgood/nvim-sensible', priority = 1001, opts = {} },
  { 'monkoose/matchparen.nvim', opts = {} },
  { 'mcauley-penney/visual-whitespace.nvim', opts = {} },
  { 'LunarVim/bigfile.nvim' },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'molecule-man/telescope-menufacture',
      -- 'nvim-telescope/telescope-ui-select.nvim',
    },
  },

  { 'nvim-treesitter/nvim-treesitter', dependencies = { 'hrsh7th/vim-gindent' } },

  {
    'saghen/blink.cmp',
    lazy = false,
    version = 'v1.*',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'marilari88/twoslash-queries.nvim', opts = { highlight = 'Comment', multi_line = true } },
      'yioneko/nvim-vtsls',
      'saecki/live-rename.nvim',
      'dgagn/diagflow.nvim',
      { 'aznhe21/actions-preview.nvim', dependencies = { 'MunifTanjim/nui.nvim' } },
      { 'j-hui/fidget.nvim', opts = { progress = { ignore_empty_message = false } } },
    },
  },

  { 'stevearc/conform.nvim' },
  { 'mfussenegger/nvim-lint' },

  { 'ojroques/nvim-hardline' },

  {
    'akinsho/bufferline.nvim',
    events = { 'BufReadPost' },
  },

  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      { 'tpope/vim-fugitive' },
      { 'junegunn/gv.vim' },
    },
  },

  {
    'kdheepak/lazygit.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    cmd = { 'LazyGit', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
    keys = {
      { '<f5>', '<cmd>LazyGit<cr>' },
    },
  },

  { 'tpope/vim-repeat' },
  { 'kkoomen/gfi.vim' },
  { 'sedm0784/vim-resize-mode' },
  {
    'smoka7/hop.nvim',
    config = function()
      require('hop').setup({ jump_on_sole_occurrence = true, create_hl_autocmd = false })
      vim.api.nvim_set_hl(0, 'HopUnmatched', { fg = 'NONE' })
      vim.keymap.set('n', 's', '<cmd>HopChar1<cr>')
      vim.keymap.set('', 'f', '<cmd>HopChar1CurrentLine<cr>')
    end,
  },
  { 'kylechui/nvim-surround', opts = {} },
  { 'numToStr/Comment.nvim', opts = { ignore = '^$' } },
  { 'folke/ts-comments.nvim', opts = {} },
  {
    'nvim-pack/nvim-spectre',
    depends = { { 'nvim-lua/plenary.nvim' } },
  },
  {
    'loqusion/star.nvim',
    config = function()
      require('star').setup({ auto_map = false })
      vim.keymap.set({ 'n', 'x' }, '*', function()
        require('star').star('star')
      end)
      vim.keymap.set({ 'n', 'x' }, 'gs', function()
        require('star').star('star')
        vim.api.nvim_feedkeys('cgn', 'nt', true)
      end)
    end,
  },
  {
    'echasnovski/mini.hipatterns',
    config = function()
      require('mini.hipatterns').setup({
        highlighters = {
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
          hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
        },
      })
    end,
  },
  {
    'nat-418/boole.nvim',
    config = function()
      require('boole').setup({
        mappings = { increment = '<C-a>', decrement = '<C-x>' },
      })
    end,
  },
  {
    'kevinhwang91/nvim-bqf',
    config = function()
      require('bqf').setup({
        preview = { auto_preview = false },
      })
    end,
  },

  {
    'JellyApple102/flote.nvim',
    config = function()
      require('flote').setup({
        notes_dir = os.getenv('HOME') .. '/Notes/',
      })
    end,
  },

  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
    keys = {
      {
        '<leader>s',
        function()
          require('persistence').load()
        end,
      },
    },
  },

  { lazy = true, 'nvim-lua/plenary.nvim' },
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    config = function()
      require('nightfox').setup({
        options = {
          colorblind = {
            enable = true,
            severity = {
              -- protan = 0.4,
              deutan = 0.4,
              tritan = 0.4,
            },
          },
        },
        groups = {
          nightfox = {
            Visual = { bg = '#2b354a' },
            VisualNonText = { fg = '#3d4b6a', bg = '#2b354a' },
            LineNr = { fg = '#5a5a7d' },
            CursorLineNr = { fg = '#a5a582' },
            MatchParen = { style = 'underline' },
            LazyGitBorder = { fg = '#394e72' },
            ['@variable'] = { fg = '#cfd4e5' },
          },
        },
      })
      vim.cmd.colorscheme('nightfox')
    end,
  },
})
