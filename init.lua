-- init.lua
vim.loader.enable()

local g = vim.g
g.mapleader = ' '
g.have_nerd_font = true
vim.g.loaded_matchparen = 1

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

local add, later = MiniDeps.add, MiniDeps.later

local map = vim.keymap.set
local vimRc = vim.api.nvim_create_augroup('vimRc', { clear = true })
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

-- colorscheme
add('navarasu/onedark.nvim')
require('onedark').setup({
  highlights = {
    ['VisualNonText'] = { fg = '#5c6370', bg = '#3b3f4c' },
    ['FzfLuaBorder'] = { fg = '#333842', bg = '#282c34' },
    ['BlinkCmpMenuBorder'] = { fg = '#383838' },
    ['BlinkCmpDocBorder'] = { fg = '#383838' },
    -- ['GitSignsAdd'] = { fg = '#54695d' },
    -- ['GitSignsChange'] = { fg = '#4e616f' },
  },
})
vim.cmd.colorscheme('onedark')

-- options
add('basilgood/nvim-sensible')
require('sensible').setup({
  options = { list = false },
})

add('monkoose/matchparen.nvim')
require('matchparen').setup()
add('mcauley-penney/visual-whitespace.nvim')
require('visual-whitespace').setup()

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
  map('n', 'gr', snacks.picker.lsp_references)
  map('n', '<f5>', snacks.lazygit.open)
  map('n', 'ghL', snacks.lazygit.log_file)
  map('n', '<f1>', snacks.terminal.toggle)
  map('t', '<f1>', snacks.terminal.toggle)
  map('n', '<leader>nn', snacks.scratch.open)
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

-- netrw
map('n', '-', function()
  local file = vim.fn.expand('%:t')
  vim.cmd('Explore')
  vim.fn.search('^' .. file .. '$', 'wc')
end)

autocmd('filetype', {
  pattern = 'netrw',
  callback = function()
    local opts = { buffer = true, remap = true }
    map('n', '.', 'mfmx', opts)
    map('n', 'P', '<cmd>wincmd w|bd|wincmd c<cr>', opts)
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

-- diagnostics
add('dgagn/diagflow.nvim')
require('diagflow').setup({ scope = 'line' })
vim.diagnostic.config({
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

-- treesitter
add('hrsh7th/vim-gindent')
vim.cmd([[
  let g:gindent = {}
  let g:gindent.enabled = { -> index(['javascript', 'typescript', 'lua'], &filetype) != -1 }
]])
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

-- lint
add('mfussenegger/nvim-lint')
local events = { 'BufWritePost', 'BufReadPost', 'InsertLeave', 'TextChanged' }

local linters_by_ft = {
  lua = { 'luacheck' },
  yaml = { 'yamllint' },
  json = { 'jsonlint' },
  -- nix = { 'statix' },
}
local lint = require('lint')
vim.api.nvim_create_autocmd(events, {
  callback = function()
    local linters = linters_by_ft
    local filetype_linters = linters[vim.bo.filetype]
    if filetype_linters then
      for _, linter in pairs(filetype_linters) do
        local executable = io.popen('which ' .. linter .. ' > /dev/null 2>&1; echo $?', 'r'):read('*l')
        if executable == '0' then
          lint.try_lint(linter)
        else
          vim.notify('Linter ' .. linter .. ' not found or not executable', vim.log.levels.WARN)
        end
      end
    end
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
      lua = { 'stylua' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      html = { 'prettier' },
      css = { 'prettier' },
      yaml = { 'prettier' },
      nix = { 'alejandra' },
      rust = { 'rustfmt' },
      sh = { 'shfmt' },
      json = { 'fixjson' },
      jsonc = { 'fixjson' },
    },
  })
  map({ 'n', 'v' }, 'Q', function()
    conform.format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
    })
    vim.schedule(function()
      vim.cmd('update')
    end)
  end)
end)

-- blink
-- add({
--   source = 'Saghen/blink.cmp',
--   checkout = 'v0.12.4',
--   depends = {
--     'rafamadriz/friendly-snippets',
--   },
-- })
-- require('blink.cmp').setup({
--   keymap = {
--     preset = 'enter',
--     ['<c-l>'] = { 'show', 'show_documentation', 'hide_documentation' },
--     ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
--     ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
--   },
--   sources = {
--     default = { 'lsp', 'path', 'snippets', 'buffer', 'markdown' },
--     providers = {
--       markdown = {
--         name = 'RenderMarkdown',
--         module = 'render-markdown.integ.blink',
--         fallbacks = { 'lsp' },
--       },
--     },
--   },
--   cmdline = { enabled = false },
--   completion = {
--     menu = { border = 'single' },
--     documentation = {
--       auto_show = true,
--       window = {
--         border = 'single',
--       },
--     },
--     list = { selection = { auto_insert = false } },
--   },
-- })
-- cmp
later(function()
  add({
    source = 'hrsh7th/nvim-cmp',
    depends = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'FelipeLema/cmp-async-path',
      'garymjr/nvim-snippets',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'onsails/lspkind.nvim',
      'rafamadriz/friendly-snippets',
    },
  })
  local cmp = require('cmp')
  require('snippets').setup({ friendly_snippets = true, global_snippets = { 'all', 'global' } })
  local lspkind = require('lspkind')
  local select_opts = { behavior = cmp.SelectBehavior.Select }
  local replace_opts = { behavior = cmp.ConfirmBehavior.Replace, select = false }
  cmp.setup({
    snippet = {
      expand = function(args)
        vim.snippet.expand(args.body)
      end,
    },
    window = {
      completion = {
        border = 'single',
        winhighlight = 'FloatBorder:Whitespace,Normal:CmpNormal',
        col_offset = 0,
        side_padding = 0,
      },
      documentation = {
        border = 'single',
        winhighlight = 'FloatBorder:Whitespace,Normal:CmpNormal',
      },
    },
    preselect = cmp.PreselectMode.None,
    mapping = {
      ['<up>'] = cmp.mapping.select_prev_item(select_opts),
      ['<down>'] = cmp.mapping.select_next_item(select_opts),
      ['<cr>'] = cmp.mapping.confirm(replace_opts),
      ['<c-e>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.snippet.active({ direction = 1 }) then
          vim.schedule(function()
            vim.snippet.jump(1)
          end)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.snippet.active({ direction = -1 }) then
          vim.schedule(function()
            vim.snippet.jump(-1)
          end)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'snippets' },
      { name = 'buffer' },
      { name = 'async_path' },
      { name = 'nvim_lsp_signature_help' },
    },
    formatting = {
      format = lspkind.cmp_format({
        preset = 'codicons',
        before = function(_, vim_item)
          vim_item.abbr = vim_item.abbr:match('[^(]+')
          return vim_item
        end,
      }),
    },
  })
end)

-- lsp
add({
  source = 'neovim/nvim-lspconfig',
  depends = { 'hrsh7th/cmp-nvim-lsp', 'yioneko/nvim-vtsls' },
})
local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

lspconfig.util.default_config = vim.tbl_deep_extend('force', lspconfig.util.default_config, {
  capabilities = cmp_nvim_lsp.default_capabilities(),
})

-- typescript ^?
add('marilari88/twoslash-queries.nvim')
require('twoslash-queries').setup({
  highlight = 'Comment',
  multi_line = true,
})

require('lspconfig.configs').vtsls = require('vtsls').lspconfig
lspconfig.vtsls.setup({
  on_attach = function(client, bufnr)
    require('twoslash-queries').attach(client, bufnr)
    command('OrganizeImports', function()
      require('vtsls').commands.organize_imports(bufnr)
    end, { desc = 'Organize Imports' })
  end,
})
lspconfig.eslint.setup({})
lspconfig.jsonls.setup({})
lspconfig.nixd.setup({ offset_encoding = 'utf-8' })
lspconfig.rust_analyzer.setup({
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
lspconfig.lua_ls.setup({
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
          '${3rd}/luv/library',
        },
        checkThirdParty = false,
      },
    },
  },
})

map('i', '<c-k>', vim.lsp.buf.signature_help, { desc = 'show signature' })
map('n', '<f4>', vim.lsp.buf.code_action)

-- live rename
add('saecki/live-rename.nvim')
map('n', '<f2>', require('live-rename').rename)

--statusline
add('ojroques/nvim-hardline')
require('hardline').setup({
  bufferline = false,
  theme = 'jellybeans',
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

-- tabline
later(function()
  add('akinsho/bufferline.nvim')
  require('bufferline').setup({
    options = {
      mode = 'tabs',
      enforce_regular_tabs = true,
      always_show_bufferline = false,
    },
  })
  map('n', '<leader><leader>', '<cmd>BufferLinePick<cr>')
end)

-- markdown
add({
  source = 'MeanderingProgrammer/render-markdown.nvim',
  depends = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
})

add({
  source = 'iamcco/markdown-preview.nvim',
  hooks = {
    post_install = function()
      vim.cmd.packadd('markdown-preview.nvim')
      vim.fn['mkdp#util#install']()
    end,
    post_checkout = function()
      vim.cmd.packadd('markdown-preview.nvim')
      vim.fn['mkdp#util#install']()
    end,
  },
})

-- git
add('lewis6991/gitsigns.nvim')
local gs = require('gitsigns')
gs.setup({
  signs = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '▎' },
    topdelete = { text = '▎' },
    changedelete = { text = '▎' },
    untracked = { text = '▎' },
  },
  signs_staged_enable = true,
  on_attach = function()
    map('n', '[c', gs.prev_hunk, { buffer = true })
    map('n', ']c', gs.next_hunk, { buffer = true })
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
  add('idanarye/vim-merginal')
  add('akinsho/git-conflict.nvim')
  require('git-conflict').setup()

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

  add({
    source = 'nvim-pack/nvim-spectre',
    depends = { 'nvim-lua/plenary.nvim' },
  })

  add('loqusion/star.nvim')
  require('star').setup({ auto_map = false })
  map({ 'n', 'x' }, '*', function()
    require('star').star('star')
  end)
  map({ 'n', 'x' }, 'gs', function()
    require('star').star('star')
    vim.api.nvim_feedkeys('cgn', 'nt', true)
  end)

  add('echasnovski/mini.hipatterns')
  require('mini.hipatterns').setup({
    highlighters = {
      fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
      todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
      note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
      hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
    },
  })

  add('nat-418/boole.nvim')
  require('boole').setup({
    mappings = { increment = '<C-a>', decrement = '<C-x>' },
  })

  add('kevinhwang91/nvim-bqf')
  require('bqf').setup({
    preview = { auto_preview = false },
  })
  add('stefandtw/quickfix-reflector.vim')

  add('JellyApple102/flote.nvim')
  require('flote').setup({
    notes_dir = os.getenv('HOME') .. '/Notes/',
  })
end)

-- sessions
later(function()
  add('folke/persistence.nvim')
  require('persistence').setup({
    options = vim.opt.sessionoptions:get(),
  })
  map('n', '<leader>s', function()
    require('persistence').load()
  end)
end)
