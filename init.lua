-- Init
vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Clone 'mini.nvim'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps'
require('mini.deps').setup({ path = { package = path_package } })

-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Config
local map = vim.keymap.set
local vimRc = vim.api.nvim_create_augroup('vimRc', { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- options
now(function()
  add('basilgood/nvim-sensible')
  require('sensible').setup({})
end)

-- colorscheme
now(function()
  vim.o.termguicolors = true
  add('rmehri01/onenord.nvim')
  add('AlexvZyl/nordic.nvim')
  require('nordic').setup({
    -- override = {
    --   Normal = {
    --     bg = '#2e3440',
    --   },
    -- String = {
    --   fg = '#829f69',
    -- },
    -- },
  })
  vim.cmd.colorscheme('nordic')
end)

-- statusline
now(function()
  add({
    source = 'ojroques/nvim-hardline',
    dependens = { 'nvim-tree/nvim-web-devicons' },
  })
  require('hardline').setup({
    theme = 'default',
    sections = {
      { class = 'mode', item = require('hardline.parts.mode').get_item, hide = 120 },
      { class = 'high', item = require('hardline.parts.git').get_item, hide = 120 },
      { class = 'med', item = require('hardline.parts.filename').get_item },
      '%<',
      { class = 'med', item = '%=' },
      { class = 'error', item = require('hardline.parts.lsp').get_error, hide = 120 },
      { class = 'warning', item = require('hardline.parts.lsp').get_warning, hide = 120 },
      { class = 'high', item = require('hardline.parts.filetype').get_item, hide = 60 },
      { class = 'mode', item = require('hardline.parts.line').get_item, hide = 120 },
    },
  })
end)

-- tabline
later(function()
  add('alvarosevilla95/luatab.nvim')
  require('luatab').setup({})
end)

-- oil
later(function()
  add({
    source = 'stevearc/oil.nvim',
    dependens = { 'nvim-tree/nvim-web-devicons' },
  })
  require('oil').setup({
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
    },
  })
  map('n', '-', '<cmd>Oil<cr>')
end)

-- treesitter
later(function()
  add('nvim-treesitter/nvim-treesitter')
  add('yioneko/nvim-yati')
  add('HiPhish/rainbow-delimiters.nvim')
  add('Jxstxs/conceal.nvim')
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
      disable = { 'javascript', 'typescript', 'html', 'rust', 'lua', 'css', 'tsx', 'json', 'toml' },
    },
    yati = {
      enable = true,
      default_fallback = 'auto',
      suppress_conflict_warning = true,
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
    },
  })
  local cmp = require('cmp')
  require('snippets').setup()
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
        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,Search:None',
        col_offset = 0,
        side_padding = 0,
      },
      documentation = {
        border = 'single',
        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,Search:None',
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
      { name = 'snippets' },
      { name = 'nvim_lsp' },
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
later(function()
  add({
    source = 'neovim/nvim-lspconfig',
    depends = {
      'hrsh7th/cmp-nvim-lsp',
      'j-hui/fidget.nvim',
      'luozhiya/lsp-virtual-improved.nvim',
      'lewis6991/hover.nvim',
      'aznhe21/actions-preview.nvim',
    },
  })
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities({
    workspace = {
      didChangeWatchedFiles = { dynamicRegistration = false },
    },
  })
  vim.diagnostic.config({
    virtual_text = false,
    underline = false,
    float = {
      border = 'single',
      header = '',
    },
    virtual_improved = {
      current_line = 'only',
    },
    virtual_lines = false,
  })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
  lspconfig.eslint.setup({
    capabilities = capabilities,
  })
  lspconfig.nil_ls.setup({
    capabilities = capabilities,
  })
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
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
    capabilities = capabilities,
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
  require('fidget').setup({
    progress = { ignore_empty_message = false },
  })
  require('lsp-virtual-improved').setup()
  require('hover').setup({
    init = function()
      require('hover.providers.lsp')
      require('hover.providers.dictionary')
    end,
  })
  map('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
  map('i', '<c-k>', vim.lsp.buf.signature_help, { desc = 'show signature' })
  map({ 'v', 'n' }, '<f4>', require('actions-preview').code_actions)
end)

later(function()
  add({
    source = 'pmizio/typescript-tools.nvim',
    depends = {
      'nvim-lua/plenary.nvim',
      'davidosomething/format-ts-errors.nvim',
    },
  })
  require('typescript-tools').setup({
    settings = {
      expose_as_code_action = {
        'organize_imports',
      },
      tsserver_file_preferences = {
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
        includeInlayParameterNameHints = 'all',
        includeInlayVariableTypeHints = true,
      },
    },
    handlers = {
      ['textDocument/publishDiagnostics'] = function(_, result, ctx)
        if result.diagnostics == nil then
          return
        end
        local idx = 1
        while idx <= #result.diagnostics do
          local entry = result.diagnostics[idx]
          local formatter = require('format-ts-errors')[entry.code]
          entry.message = formatter and formatter(entry.message) or entry.message
          idx = idx + 1
        end
        vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx)
      end,
    },
  })
  map('n', '<leader>i', '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>')

  add('folke/trouble.nvim')
  require('trouble').setup({})
end)

-- lint
later(function()
  add('mfussenegger/nvim-lint')
  require('lint').linters_by_ft = {
    lua = { 'luacheck' },
    -- javascript = { 'eslint' },
    -- typescript = { 'eslint' },
    yaml = { 'yamllint' },
    json = { 'jsonlint' },
  }

  vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost', 'BufReadPost' }, {
    callback = function()
      local lint_status, lint = pcall(require('lint').linters_by_ft[vim.bo.filetype], 'lint')
      if lint_status then
        lint.try_lint()
      end
    end,
  })
end)

-- formatter
later(function()
  add('stevearc/conform.nvim')
  local conform = require('conform')
  conform.setup({
    formatters = {
      shfmt = {
        prepend_args = { '-i', '2', '-ci' },
      },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      nix = { 'alejandra' },
      rust = { 'rustfmt' },
      sh = { 'shfmt' },
      yaml = { 'prettier' },
      json = { 'jq' },
      jsonc = { 'jq' },
    },
  })
  map('n', '=', function()
    conform.format()
    vim.cmd.update()
  end)
end)

-- git
later(function()
  add({
    source = 'lewis6991/gitsigns.nvim',
    depends = {
      'sindrets/diffview.nvim',
      'tpope/vim-fugitive',
      'sankhesh/gitv',
    },
  })
  if vim.fn.executable('nvr') == 1 then
    vim.env.GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=delete'"
  end
  local gs = require('gitsigns')
  gs.setup({
    signs = { untracked = { text = '' } },
    _signs_staged_enable = true,
    _signs_staged = {
      add = { text = '┋ ' },
      change = { text = '┋ ' },
      delete = { text = '﹍' },
      topdelete = { text = '﹉' },
      changedelete = { text = '┋ ' },
    },
    on_attach = function()
      map('n', '[c', gs.prev_hunk, { buffer = true })
      map('n', ']c', gs.next_hunk, { buffer = true })
      map('n', 'ghs', gs.stage_hunk)
      map('n', 'ghr', gs.reset_hunk)
      map('n', 'ghu', gs.undo_stage_hunk)
      map('n', 'ghp', gs.preview_hunk)
      map('n', 'ghB', function()
        gs.blame_line({ full = true })
      end)
      map('n', 'ghb', gs.toggle_current_line_blame)
      map('n', 'ghd', gs.diffthis)
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end,
  })
  map('n', 'ghg', '<cmd>tab G<cr>')
  autocmd('FileType', {
    pattern = { 'fugitive', 'git' },
    group = vimRc,
    callback = function(args)
      map('n', 'ghl', '<cmd>tab G log<cr>', { buffer = args.buf })
      map('n', 'gha', '<cmd>tab G log --oneline --graph --decorate --all<cr>', { buffer = args.buf })
      map('n', 'ghs', '<cmd>tab G<cr>', { buffer = args.buf })
      map('n', 'ghb', '<cmd>tab G branch -va<cr>', { buffer = args.buf })
      map('n', 'ghd', ':G branch -D ', { buffer = args.buf })
      map('n', 'ghf', '<cmd>G fetch --all --prune<cr>', { buffer = args.buf })
    end,
  })
  map('n', 'ghl', '<cmd>tab G log<cr>')
end)

-- fzf-lua
later(function()
  add('ibhagwan/fzf-lua')
  local opts = {
    'telescope',
    winopts = {
      width = 0.55,
      height = 0.7,
      preview = {
        layout = 'vertical',
        vertical = 'up:60%',
      },
    },
  }
  require('fzf-lua').setup(opts)
  require('fzf-lua').register_ui_select()
  map(
    'n',
    '<c-p>',
    '<cmd>lua require("fzf-lua").files({ cmd = "fd -tf -tl -H -E=.git -E=node_modules --strip-cwd-prefix" })<cr>'
  )
  map('n', '<bs>', '<cmd>FzfLua buffers<cr>')
  map('n', '<leader>g', '<cmd>FzfLua live_grep_glob<cr>')
  map('n', '<leader>w', '<cmd>FzfLua grep_cword<cr>')
  map('x', '<leader>w', '<cmd>FzfLua grep_visual<cr>')
  map('n', '<leader>o', '<cmd>FzfLua oldfiles<cr>')
  map('n', '<leader>h', '<cmd>FzfLua help_tags<cr>')
  map('n', '<leader>r', '<cmd>FzfLua resume<cr>')
  map('n', 'z=', function()
    require('fzf-lua').spell_suggest({
      winopts = { relative = 'cursor', row = 1.01, col = 0, height = 0.2, width = 0.5 },
    })
  end)
  map('n', 'gd', function()
    require('fzf-lua').lsp_definitions({ jump_to_single_result = true })
  end)
  map('n', 'gD', '<cmd>FzfLua lsp_definitions<cr>')
  map('n', 'gr', '<cmd>FzfLua lsp_references<cr>')
  map('n', 'gy', '<cmd>FzfLua lsp_implementations<cr>')
  map('n', '<f4>', '<cmd>FzfLua lsp_code_actions<cr>')
  map('n', '<leader>d', '<cmd>FzfLua diagnostics_document<cr>')
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

-- misc
later(function()
  add('3rd/image.nvim')
  require('image').setup()
  require('mini.bufremove').setup()
  map('n', '<c-w>d', function()
    require('mini.bufremove').delete(0, false)
  end)
  require('mini.jump').setup()
  add('kylechui/nvim-surround')
  require('nvim-surround').setup()
  add('numToStr/Comment.nvim')
  require('Comment').setup({ ignore = '^$' })
  add('folke/ts-comments.nvim')
  require('ts-comments').setup({})
  add('nvimdev/hlsearch.nvim')
  require('hlsearch').setup()
  add('linjiX/vim-star')
  map({ 'n', 'x' }, '*', '<Plug>(star-*)')
  map({ 'n', 'x' }, 'gs', '<Plug>(star-*)cgn')
  add('basilgood/pounce.nvim')
  require('pounce').setup({
    accept_keys = 'jfkdlsahgnuvrbytmiceoxwpqz',
  })
  map('n', 's', '<cmd>Pounce<cr>')
  add('smjonas/inc-rename.nvim')
  require('inc_rename').setup({ save_in_cmdline_history = false })
  vim.keymap.set('n', '<f2>', function()
    return ':IncRename ' .. vim.fn.expand('<cword>')
  end, { expr = true })
  add('stevearc/dressing.nvim')
  add('NStefan002/screenkey.nvim')
  require('screenkey').setup({})
  add('smjonas/live-command.nvim')
  require('live-command').setup({
    commands = {
      Norm = { cmd = 'norm' },
    },
  })
  add('mg979/vim-visual-multi')
  add('kkoomen/gfi.vim')
  add('LunarVim/bigfile.nvim')
  add('nvim-tree/nvim-web-devicons')
  add({
    source = 'nvim-pack/nvim-spectre',
    depends = { 'nvim-lua/plenary.nvim' },
  })
  add('kevinhwang91/nvim-bqf')
  require('bqf').setup({
    auto_resize_height = true,
    preview = {
      auto_preview = false,
      winblend = 1,
    },
  })
  add('ashfinal/qfview.nvim')
  require('qfview').setup()
end)

-- mappings
now(function()
  map('n', ']q', ':cnext<cr>')
  map('n', '[q', ':cprev<cr>')
  map('n', '<C-w>z', [[:wincmd z<bar>cclose<bar>lclose<cr>]], { silent = true })
  map('x', 'il', 'g_o^', { silent = true })
  map('o', 'il', ':normal vil<cr>', { silent = true })
  map('n', '[d', vim.diagnostic.goto_prev)
  map('n', ']d', vim.diagnostic.goto_next)
  map('n', 'gl', vim.diagnostic.open_float)
end)

-- autocmds
now(function()
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
    command = 'setlocal conceallevel=2 concealcursor=vc',
  })
end)
