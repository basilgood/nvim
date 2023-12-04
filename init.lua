-- init
vim.loader.enable()

local vimRc = vim.api.nvim_create_augroup('vimRc', { clear = true })
local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set
local install_path = vim.fn.stdpath('data') .. '/site/pack/paqs/opt/paq-nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({ 'git', 'clone', 'git@github.com:savq/paq-nvim.git', install_path })
end

vim.cmd.packadd('paq-nvim')
require('paq')({
  { 'savq/paq-nvim', opt = true },
  { 'nvim-lua/plenary.nvim', opt = true },
  'basilgood/nvim-sensible',
  'nvim-tree/nvim-web-devicons',
  'stevearc/oil.nvim',
  { 'ibhagwan/fzf-lua', opt = true },
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'FelipeLema/cmp-async-path',
  'dcampos/nvim-snippy',
  'dcampos/cmp-snippy',
  { 'onsails/lspkind.nvim', opt = true },
  'seblj/nvim-echo-diagnostics',
  'nvim-treesitter/nvim-treesitter',
  'yioneko/nvim-yati',
  'HiPhish/rainbow-delimiters.nvim',
  { 'stevearc/conform.nvim', opt = true },
  { 'mfussenegger/nvim-lint', opt = true },
  'numToStr/Comment.nvim',
  'JoosepAlviste/nvim-ts-context-commentstring',
  'nvimdev/lspsaga.nvim',
  'kylechui/nvim-surround',
  'windwp/nvim-autopairs',
  'linjiX/vim-star',
  'Jxstxs/conceal.nvim',
  'folke/trouble.nvim',
  'nvimdev/hlsearch.nvim',
  'tpope/vim-fugitive',
  'lewis6991/gitsigns.nvim',
  'akinsho/git-conflict.nvim',
  'j-hui/fidget.nvim',
  'basilgood/pounce.nvim',
  'winston0410/cmd-parser.nvim',
  'winston0410/range-highlight.nvim',
  'stevearc/dressing.nvim',
  'LunarVim/bigfile.nvim',
  'Djancyp/cheat-sheet',
  'Selyss/mind.nvim',
  'folke/persistence.nvim',
  'nvim-lualine/lualine.nvim',
  { 'EdenEast/nightfox.nvim', opt = true },
})

vim.cmd.packadd('plenary.nvim')

-- sensible/oil
require('sensible').setup({})
require('oil').setup({
  view_options = {
    show_hidden = true,
  },
})
map('n', '-', '<cmd>Oil<cr>')

-- fzf
vim.cmd.packadd('fzf-lua')
require('fzf-lua').setup({ winopts = { width = 0.7, preview = { layout = 'vertical', vertical = 'up:60%' } } })
map(
  'n',
  '<c-p>',
  '<cmd>lua require("fzf-lua").files({ cmd = "fd -tf -L -H -E=.git -E=node_modules --strip-cwd-prefix" })<cr>'
)
map('n', '<bs>', '<cmd>lua require("fzf-lua").buffers()<cr>')
map('n', '<leader>g', '<cmd>lua require("fzf-lua").grep({ search = "" })<cr>')
map('n', '<leader>w', '<cmd>lua require("fzf-lua").grep_cword()<cr>')
map('x', '<leader>w', '<cmd>lua require("fzf-lua").grep_visual()<cr>')
vim.cmd([[command! History FzfLua oldfiles]])

-- diagnostics
vim.diagnostic.config({
  virtual_text = false,
  underline = false,
  float = {
    focusable = false,
    border = 'rounded',
  },
})

local signs = { Error = '🞬', Warn = '', Hint = '', Info = '' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- nvim-echo-diagnostics
autocmd('CursorHold', {
  pattern = '*',
  group = vimRc,
  callback = function()
    require('echo-diagnostics').echo_line_diagnostic()
  end,
})

-- lsp
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.offsetEncoding = 'utf-16'

local opts = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
}

local function organize_imports()
  local params = {
    command = '_typescript.organizeImports',
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = '',
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup({
  opts,
  commands = {
    OI = {
      organize_imports,
    },
  },
})
lspconfig.nil_ls.setup({ opts })
lspconfig.lua_ls.setup({
  opts,
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { 'vim' },
        disable = {
          'missing-fields',
          'no-unknown',
        },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
        checkThirdParty = false,
      },
    },
  },
})
lspconfig.rust_analyzer.setup({
  opts,
  settings = {
    ['rust-analyzer'] = {
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
})

require('lspsaga').setup({
  lightbulb = { virtual_text = false, sign = false },
  definition = {
    keys = {
      edit = '<cr>',
      vsplit = '<c-v>',
      split = '<c-s>',
      tabe = '<c-t>',
    },
  },
})
map('n', '<leader>d', '<cmd>TroubleToggle document_diagnostics<cr>')
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<F2>', '<cmd>Lspsaga rename<cr>')
map('n', '<F4>', '<cmd>Lspsaga code_action<cr>')
map('n', 'gd', '<cmd>Lspsaga peek_definition<cr>')
map('n', 'go', '<cmd>Lspsaga finder<cr>')
map('n', 'gr', '<cmd>Trouble lsp_references<cr>')
map('n', 'K', '<cmd>Lspsaga hover_doc<cr>')
map('n', '<c-k>', vim.lsp.buf.signature_help)

-- fidget
require('fidget').setup({
  progress = { ignore_empty_message = false },
})

-- cmp
vim.cmd.packadd('lspkind.nvim')
local cmp = require('cmp')
local lspkind = require('lspkind')
local select_opts = { behavior = cmp.SelectBehavior.Select }
local replace_opts = { behavior = cmp.ConfirmBehavior.Replace, select = false }

cmp.setup({
  completion = {
    completeopt = 'menu,menuone',
  },
  preselect = cmp.PreselectMode.Item,
  snippet = {
    expand = function(args)
      require('snippy').expand_snippet(args.body)
    end,
  },
  mapping = {
    ['<up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<down>'] = cmp.mapping.select_next_item(select_opts),
    ['<tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<s-tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    ['<cr>'] = cmp.mapping.confirm(replace_opts),
    ['<c-e>'] = cmp.mapping.abort(),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'snippy' },
    { name = 'buffer' },
    { name = 'async_path' },
    { name = 'nvim_lsp_signature_help' },
  }),
  window = {
    completion = {
      border = 'none',
      winhighlight = 'Pmenu:Pmenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
    },
    documentation = {
      border = 'single',
      winhighlight = 'Pmenu:Pmenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
    },
  },
  formatting = {
    fields = { 'abbr', 'kind', 'menu' },
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format({
        preset = 'codicons',
      })(entry, vim_item)
      vim_item.abbr = vim_item.abbr:match('[^(]+')
      return kind
    end,
  },
})

require('snippy').setup({
  mappings = {
    is = {
      ['<c-l>'] = 'expand_or_advance',
      ['<c-h>'] = 'previous',
    },
  },
})

-- treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'astro',
    'bash',
    'css',
    'go',
    'javascript',
    'jsdoc',
    'json',
    'jsonc',
    'html',
    'http',
    'lua',
    'markdown',
    'markdown_inline',
    'nix',
    'regex',
    'rust',
    'scss',
    'toml',
    'tsx',
    'typescript',
    'yaml',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  yati = {
    enable = true,
    default_fallback = 'auto',
    suppress_conflict_warning = true,
  },
  indent = {
    enable = true,
    disable = { 'javascript', 'typescript', 'html', 'rust', 'lua', 'css', 'tsx', 'json', 'toml' },
  },
})

-- ts-context-commentstring
vim.g.skip_ts_context_commentstring_module = true
require('ts_context_commentstring').setup({
  enable_autocmd = false,
})

-- linter
vim.cmd.packadd('nvim-lint')
require('lint').linters_by_ft = {
  lua = { 'luacheck' },
  nix = { 'statix' },
  javascript = { 'eslint' },
  typescript = { 'eslint' },
  yaml = { 'yamllint' },
  json = { 'jsonlint' },
}

vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
  command = 'silent! lua require("lint").try_lint()',
})

--formatter
vim.cmd.packadd('conform.nvim')
require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    nix = { 'alejandra' },
    rust = { 'rustfmt' },
    sh = { 'shfmt' },
    yaml = { 'yamlfmt' },
    json = { 'jq' },
    jsonc = { 'jq' },
  },
})

map('n', 'Q', function()
  require('conform').format()
end)

-- misc
require('nvim-surround').setup()
require('Comment').setup({ ignore = '^$' })
require('nvim-autopairs').setup({
  disable_filetype = { 'TelescopePrompt', 'vim', 'markdown' },
})
require('hlsearch').setup()
require('range-highlight').setup({})
require('mind').setup()

-- git
if vim.fn.executable('nvr') == 1 then
  vim.env.GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=delete'"
end

local gitsigns = require('gitsigns')
gitsigns.setup({
  on_attach = function()
    map('n', '[c', gitsigns.prev_hunk, { buffer = true })
    map('n', ']c', gitsigns.next_hunk, { buffer = true })
    map('n', 'ghp', gitsigns.preview_hunk, { buffer = true })
    map('n', 'ghu', gitsigns.reset_hunk, { buffer = true })
    map('n', 'ghb', gitsigns.toggle_current_line_blame, { buffer = true })
  end,
})
map('n', 'ghd', '<cmd>Gvdiffsplit!<cr>')
require('git-conflict').setup()

-- lualine
require('lualine').setup({
  options = {
    globalstatus = true,
    component_separators = {},
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        right_padding = 2,
        fmt = function(str)
          return str:lower():sub(1, 1)
        end,
      },
    },
    lualine_b = { { 'branch', icon = '' } },
    lualine_c = {
      '%=',
      { 'filename', file_status = false, path = 0 },
      {
        function()
          if vim.bo.modified then
            return ''
          elseif vim.bo.modifiable == false or vim.bo.readonly == true then
            return '-'
          end
          return ''
        end,
        color = { fg = '#ca1243' },
      },
    },
    lualine_x = { 'diagnostics' },
    lualine_y = { 'filetype' },
    lualine_z = { '%2c:%l/%L' },
  },
})

-- sessions
require('persistence').setup({ dir = vim.fn.expand(vim.fn.stdpath('data') .. '/sessions/') })
map('n', '<leader>s', '<cmd>lua require("persistence").load()<cr>')

-- keymaps
map('n', ']q', ':cnext<cr>')
map('n', '[q', ':cprev<cr>')
map('n', '<C-w>d', [[:bp<bar>bd#<cr>]], { silent = true })
map('n', '<C-w>z', [[:wincmd z<bar>cclose<bar>lclose<cr>]], { silent = true })
map('n', '3<C-g>', [[:echo system('cat .git/HEAD')->split('\n')<cr>]])
map('n', 'vv', 'viw', { silent = true })
map('x', 'il', 'g_o^', { silent = true })
map('o', 'il', ':normal vil<cr>', { silent = true })
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map({ 'n', 'x' }, '*', '<Plug>(star-*)')
map({ 'n', 'x' }, 'gs', '<Plug>(star-*)cgn')
map('n', 'z=', function()
  local word = vim.fn.expand('<cword>')
  local suggestions = vim.fn.spellsuggest(word)
  vim.ui.select(
    suggestions,
    {},
    vim.schedule_wrap(function(selected)
      if selected then
        vim.cmd.normal({ args = { 'ciw' .. selected }, bang = true })
      end
    end)
  )
end)
map('n', '<leader>h', '<cmd>CheatSH<cr>')
map('n', 's', '<cmd>Pounce<cr>')
map({ 'n', 'x' }, '*', '<Plug>(star-*)')
map({ 'n', 'x' }, 'gs', '<Plug>(star-*)cgn')
map('n', '<leader>q', '<cmd>Trouble quickfix<cr>')

-- autocmds
autocmd('TextYankPost', {
  group = vimRc,
  callback = function()
    vim.highlight.on_yank()
  end,
})
autocmd('FileType', { pattern = { 'qf', 'help', 'man' }, group = vimRc, command = 'wincmd J' })
autocmd('FileType', { group = vimRc, pattern = '*', command = 'set formatoptions-=o' })
autocmd('BufRead', { pattern = '*', group = vimRc, command = [[call setpos(".", getpos("'\""))]] })
autocmd('BufReadPre', {
  pattern = '*.json',
  group = vimRc,
  command = 'setlocal conceallevel=0 concealcursor= formatoptions=',
})
autocmd('BufReadPre', {
  pattern = '*{.md,.markdown}',
  group = vimRc,
  command = 'setlocal conceallevel=2 concealcursor=vc',
})

-- filetype
vim.filetype.add({
  extension = {
    conf = 'config',
    njk = 'htmldjango',
  },
  filename = {
    ['.luacheckrc'] = 'lua',
  },
})

vim.cmd.packadd('nightfox.nvim')
vim.cmd.colorscheme('nightfox')
