-- init.lua

local g = vim.g
g.mapleader = ' '
g.have_nerd_font = true
vim.g.loaded_matchparen = 1
vim.g.autoformat = true

local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.deps'

if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.deps', mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.deps | helptags ALL')
  vim.cmd('echo "Installed `mini.deps`" | redraw')
end

require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

local map = vim.keymap.set
local vimRc = vim.api.nvim_create_augroup('vimRc', { clear = true })
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

-- options
add('navarasu/onedark.nvim')
require('onedark').setup({
  style = 'darker',
  colors = {
    purple = '#a288d4',
    blue = '#5fb5fb',
    red = '#e76dba',
    green = '#779960',
  },
  highlights = {
    VisualNonText = { fg = '#4a4f59', bg = '#323641' },
    GitsignsAddInline = { bg = '#404040' },
    GitsignsDeleteInline = { bg = '#404040' },
  },
})
require('onedark').load()
add('basilgood/nvim-sensible')
require('sensible').setup({})
add('monkoose/matchparen.nvim')
require('matchparen').setup()
add('mcauley-penney/visual-whitespace.nvim')
require('visual-whitespace').setup({})
add('echasnovski/mini.icons')
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()
MiniIcons.tweak_lsp_kind()
add('hrsh7th/nvim-anydent')
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    if not vim.tbl_contains({ 'html', 'yaml', 'markdown' }, vim.bo.filetype) then
      require('anydent').attach()
    end
  end,
})

-- mappings
map('n', ']q', ':cnext<cr>')
map('n', '[q', ':cprev<cr>')
map('n', ']l', ':lnext<cr>')
map('n', '[l', ':lprev<cr>')
map('x', 'il', 'g_o^', { silent = true })
map('o', 'il', ':normal vil<cr>', { silent = true })
map({ 'n', 'x' }, 'j', 'gj')
map({ 'n', 'x' }, 'k', 'gk')
map({ 'n', 'x' }, '<down>', 'gj')
map({ 'n', 'x' }, '<up>', 'gk')

-- autocmds
autocmd('TextYankPost', {
  group = vimRc,
  callback = function()
    vim.highlight.on_yank()
  end,
})
autocmd('FileType', {
  group = vimRc,
  pattern = {
    'help',
    'man',
    'qf',
    'query',
    'scratch',
    'spectre_panel',
    'grug-far',
    'git',
    'fugitive',
  },
  callback = function(args)
    map('n', 'q', '<cmd>quit<cr>', { buffer = args.buf })
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
  command = 'setlocal conceallevel=2 concealcursor=vc wrap linebreak breakindentopt=shift:2,min:40,sbr colorcolumn=121',
})
autocmd({ 'FocusGained', 'WinEnter', 'TermClose', 'TermLeave' }, {
  command = 'checktime',
})
autocmd('LspProgress', {
  callback = function(ev)
    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    vim.notify(vim.lsp.status(), 'info', {
      id = 'lsp_progress',
      title = 'LSP Progress',
      opts = function(notif)
        notif.icon = ev.data.params.value.kind == 'end' and ' '
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

-- treesitter
later(function()
  add('nvim-treesitter/nvim-treesitter')
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'astro',
      'bash',
      'css',
      'comment',
      'csv',
      'diff',
      'gitcommit',
      'git_rebase',
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
      'styled',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
      'cpp',
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        node_incremental = 'v',
        node_decremental = 'V',
        scope_incremental = false,
      },
    },
  })
end)

-- diagnostics
add('dgagn/diagflow.nvim')
require('diagflow').setup({ scope = 'line' })
vim.diagnostic.config({
  virtual_lines = false,
  underline = false,
  float = {
    border = 'single',
    header = '',
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.HINT] = 'ʰ',
      [vim.diagnostic.severity.ERROR] = 'ᵉ',
      [vim.diagnostic.severity.INFO] = 'ⁱ',
      [vim.diagnostic.severity.WARN] = 'ʷ',
    },
  },
})
map('n', 'gl', vim.diagnostic.open_float)

-- lint
add('mfussenegger/nvim-lint')
local events = { 'BufWritePost', 'BufReadPost', 'InsertLeave', 'TextChanged' }
local linters_by_ft = {
  lua = { 'luacheck' },
  yaml = { 'yamllint' },
  -- javascript = { 'eslint' },
  -- typescript = { 'eslint' },
  -- json = { 'jsonlint' },
  -- nix = { 'statix' },
}
local executable_linters = {}

for filetype, linters in pairs(linters_by_ft) do
  for _, linter in ipairs(linters) do
    if vim.fn.executable(linter) == 1 then
      if executable_linters[filetype] == nil then
        executable_linters[filetype] = {}
      end
      table.insert(executable_linters[filetype], linter)
    end
  end
end

require('lint').linters_by_ft = executable_linters

vim.api.nvim_create_autocmd(events, {
  callback = function()
    require('lint').try_lint()
  end,
})

-- formatter
later(function()
  add('stevearc/conform.nvim')
  local conform = require('conform')
  conform.setup({
    formatters = {
      shfmt = {
        inherit = false,
        command = 'shfmt',
        args = { '-i', '2', '-ci', '-filename', '$FILENAME' },
      },
    },
    formatters_by_ft = {
      c = { name = 'clangd', timeout_ms = 500, lsp_format = 'prefer' },
      html = { 'prettier', timeout_ms = 500, lsp_format = 'fallback' },
      javascript = { 'prettier', timeout_ms = 500, lsp_format = 'fallback' },
      javascriptreact = { 'prettier', timeout_ms = 500, lsp_format = 'fallback' },
      json = { 'jq' },
      jsonc = { 'jq' },
      less = { 'prettier' },
      lua = { 'stylua' },
      markdown = { 'prettier' },
      nix = { 'nixfmt' },
      rust = { name = 'rust_analyzer', timeout_ms = 500, lsp_format = 'prefer' },
      scss = { 'prettier' },
      sh = { 'shfmt' },
      typescript = { 'prettier', timeout_ms = 500, lsp_format = 'fallback' },
      typescriptreact = { 'prettier', timeout_ms = 500, lsp_format = 'fallback' },
      ['_'] = { 'trim_whitespace', 'trim_newlines' },
    },
    format_on_save = function()
      if not vim.g.autoformat then
        return nil
      end
      return {}
    end,
  })

  command('ToggleFormat', function()
    vim.g.autoformat = not vim.g.autoformat
    vim.notify(string.format('%s formatting...', vim.g.autoformat and 'Enabling' or 'Disabling'), vim.log.levels.INFO)
  end, { desc = 'Toggle conform.nvim auto-formatting', nargs = 0 })
end)

--lsp
-- vim.lsp.semantic_tokens.start = function() end
add({
  source = 'neovim/nvim-lspconfig',
  depends = {
    'yioneko/nvim-vtsls',
    'marilari88/twoslash-queries.nvim',
  },
})

require('twoslash-queries').setup({
  highlight = 'Comment',
  multi_line = true,
})

local lspconfig = require('lspconfig')
require('lspconfig.configs').vtsls = require('vtsls').lspconfig
lspconfig.vtsls.setup({
  on_attach = function(client)
    require('twoslash-queries').attach(client)
    command('OrganizeImports', function()
      require('vtsls').commands.organize_imports(0)
    end, { desc = 'Organize Imports' })
  end,
})
lspconfig.eslint.setup({})
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      hint = { enable = true },
      telemetry = { enable = false },
      workspace = { checkThirdParty = false },
    },
  },
})
lspconfig.nixd.setup({})
lspconfig.clangd.setup({
  cmd = {
    'clangd',
    '--clang-tidy',
    '--header-insertion=iwyu',
    '--completion-style=detailed',
    '--fallback-style=none',
    '--function-arg-placeholders=false',
  },
})

-- completion
later(function()
  add({
    source = 'saghen/blink.cmp',
    checkout = 'v1.1.1',
    depends = {
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
  })
  require('luasnip.loaders.from_vscode').lazy_load()
  require('blink.cmp').setup({
    cmdline = { enabled = false },
    snippets = { preset = 'luasnip' },
    appearance = { use_nvim_cmp_as_default = true, nerd_font_variant = 'normal' },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
    keymap = {
      ['<CR>'] = { 'accept', 'fallback' },
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    },
    completion = {
      list = {
        selection = { preselect = true, auto_insert = false },
      },
      menu = {
        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,EndOfBuffer:EndOfBuffer',
      },
      documentation = {
        auto_show = true,
        window = {
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,EndOfBuffer:EndOfBuffer',
        },
      },
    },
  })
end)

-- overseer
add('stevearc/overseer.nvim')
local overseer = require('overseer')
overseer.setup({
  task_list = {
    default_detail = 1,
    direction = 'bottom',
    max_width = { 600, 0.7 },
    bindings = {
      ['<C-b>'] = 'ScrollOutputUp',
      ['<C-f>'] = 'ScrollOutputDown',
      ['H'] = 'IncreaseAllDetail',
      ['L'] = 'DecreaseAllDetail',
    },
  },
})
map('n', '<leader>oo', '<cmd>OverseerToggle<cr>')
map('n', '<leader>or', '<cmd>OverseerRun<cr>')
map('n', '<leader>oc', '<cmd>OverseerRunCmd<cr>')
map('n', '<leader>ol', function()
  local tasks = overseer.list_tasks({ recent_first = true })
  if vim.tbl_isempty(tasks) then
    vim.notify('No tasks found', vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], 'restart')
    overseer.open({ enter = false })
  end
end)

-- markdown
add({ source = 'OXY2DEV/markview.nvim' })

--statusline
add('ojroques/nvim-hardline')
require('hardline').setup({
  bufferline = false,
  theme = 'one',
  sections = {
    { class = 'mode', item = '%{mode()}', hide = 40 },
    { class = 'high', item = require('hardline.parts.git').get_item, hide = 120 },
    { class = 'med', item = '%{expand("%:p:h:t")}/%t %{&modified?" ":""} %r' },
    '%<',
    { class = 'med', item = '%=' },
    { class = 'error', item = require('hardline.parts.lsp').get_error },
    { class = 'warning', item = require('hardline.parts.lsp').get_warning },
    { class = 'high', item = require('hardline.parts.filetype').get_item, hide = 60 },
    { class = 'mode', item = require('hardline.parts.line').get_item, hide = 60 },
  },
})

-- snacks
add('folke/snacks.nvim')
require('snacks').setup({
  bigfile = {
    enabled = true,
    notify = false,
    setup = function()
      vim.b.current_syntax = ''
    end,
  },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  gitbrowse = { enabled = true },
  input = { enabled = true },
  picker = {
    enabled = true,
    ui_select = true,
    formatters = {
      file = { filename_first = true, truncate = 60 },
    },
    layout = { cycle = false, preview = false, preset = 'vertical' },
  },
})

later(function()
  local snacks = require('snacks')
  command('Gbrowse', 'lua Snacks.gitbrowse()', {})
  command('Rename', 'lua Snacks.rename.rename_file()', {})
  command('Notifications', 'lua Snacks.notifier.show_history()', {})
  map('n', '<leader>d', snacks.picker.diagnostics_buffer)
  map('n', 'gd', snacks.picker.lsp_definitions)
  map('n', '<f5>', snacks.lazygit.open)
  map('n', 'ghL', snacks.lazygit.log_file)
  map('n', '<f1>', snacks.terminal.toggle)
  map('t', '<f1>', snacks.terminal.toggle)
  map('t', '<c-n>', '<C-\\><C-n>')
  map('n', '<leader>no', snacks.scratch.open)
  map('n', '<leader>ns', snacks.scratch.select)
  map('n', 'z=', snacks.picker.spelling)
  map('n', '<c-w>d', snacks.bufdelete.delete)
  map('n', '<c-w>D', snacks.bufdelete.other)
  map('n', '<c-p>', function()
    Snacks.picker.files({ hidden = true })
  end)
  map('n', '<bs>', function()
    Snacks.picker.buffers({ current = false })
  end)
  map('n', '<leader>g', function()
    Snacks.picker.grep({ hidden = true })
  end)
end)

-- mini files
later(function()
  add('echasnovski/mini.files')
  require('mini.files').setup({
    windows = {
      preview = false,
      width_preview = 75,
    },
    mappings = {
      go_in_plus = '<cr>',
      go_out_plus = '-',
    },
    options = {
      permanent_delete = true,
      use_as_default_explorer = true,
    },
  })
  map('n', '-', function()
    local bufname = vim.api.nvim_buf_get_name(0)
    local path = vim.fn.fnamemodify(bufname, ':p')
    if path and vim.uv.fs_stat(path) then
      require('mini.files').open(bufname, false)
    end
  end)
end)

-- git
add('lewis6991/gitsigns.nvim')
local gs = require('gitsigns')
gs.setup({
  signs = {
    add = { text = '│' },
    change = { text = '│' },
  },
  signs_staged_enable = false,
  on_attach = function()
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gs.nav_hunk('next')
      end
    end)
    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gs.nav_hunk('prev')
      end
    end)
    map('n', 'ghr', gs.reset_hunk)
    map('n', 'ghp', gs.preview_hunk)
    map('n', 'ghB', function()
      gs.blame_line({ full = true })
    end)
    map('n', 'ghb', gs.toggle_current_line_blame)
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
})

later(function()
  add('tpope/vim-fugitive')
  add('junegunn/gv.vim')
  add('idbrii/vim-mergetool')
  map('n', '<C-Left>', function()
    return vim.wo.diff and '<Plug>(MergetoolDiffExchangeLeft)' or '<C-Left>'
  end, { expr = true })
  map('n', '<C-Right>', function()
    return vim.wo.diff and '<Plug>(MergetoolDiffExchangeRight)' or '<C-Right>'
  end, { expr = true })
  map('n', '<C-Down>', function()
    return vim.wo.diff and '<Plug>(MergetoolDiffExchangeDown)' or '<C-Down>'
  end, { expr = true })
  map('n', '<C-Up>', function()
    return vim.wo.diff and '<Plug>(MergetoolDiffExchangeUp)' or '<C-Up>'
  end, { expr = true })
  add('cvigilv/diferente.nvim')
  require('diferente').setup({})
  map('n', 'ghg', '<cmd>tab G<cr>')
  map('n', 'ghd', '<cmd>Gvdiffsplit!<cr>')
  map('n', 'ghl', '<cmd>GV --all<cr>')
  map('n', 'ght', '<cmd>GV --no-graph --no-walk --tags<cr>')
end)

-- misc
later(function()
  add('tpope/vim-repeat')
  add('kkoomen/gfi.vim')
  add('sedm0784/vim-resize-mode')
  add('michaeljsmith/vim-indent-object')
  add('smoka7/hop.nvim')
  require('hop').setup({ jump_on_sole_occurrence = true, create_hl_autocmd = false })
  vim.api.nvim_set_hl(0, 'HopUnmatched', { fg = 'NONE' })
  map('n', 's', '<cmd>HopChar1<cr>')
  map('', 'f', '<cmd>HopChar1CurrentLine<cr>')
  add('kylechui/nvim-surround')
  require('nvim-surround').setup()
  add('numToStr/Comment.nvim')
  require('Comment').setup({ ignore = '^$' })
  add('folke/ts-comments.nvim')
  require('ts-comments').setup({})
  add('nat-418/boole.nvim')
  require('boole').setup({
    mappings = { increment = '<C-a>', decrement = '<C-x>' },
  })
  add('edte/normal-colon.nvim')
  require('normal-colon').setup()
  add('kevinhwang91/nvim-bqf')
  require('bqf').setup({
    preview = { auto_preview = false },
  })
  add('stevearc/quicker.nvim')
  require('quicker').setup()
  autocmd('FileType', {
    group = vimRc,
    pattern = 'qf',
    callback = function(args)
      map('n', 'q', '<cmd>quit<cr>', { buffer = args.buf })
      map('n', '>', [[<cmd>lua require("quicker").expand()<cr>]])
      map('n', '<', [[<cmd>lua require("quicker").collapse()<cr>]])
    end,
  })
  add('JellyApple102/flote.nvim')
  require('flote').setup({
    notes_dir = os.getenv('HOME') .. '/Notes/',
  })
  add('MagicDuck/grug-far.nvim')
  require('grug-far').setup({ headerMaxWidth = 80 })
  add('jake-stewart/normon.nvim')
  local normon = require('normon')
  normon('gs', 'cgn')
  normon('gS', 'cgN')
  normon('*', 'nN', { clearSearch = true })
  add('jake-stewart/filestack.nvim')
  require('filestack').setup()
end)

-- sessions
add('folke/persistence.nvim')
require('persistence').setup({
  options = vim.opt.sessionoptions:get(),
})
map('n', '<leader>s', function()
  require('persistence').load()
end)
