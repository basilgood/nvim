-- init

local g = vim.g
local map = vim.keymap.set
local vimRc = vim.api.nvim_create_augroup('vimRc', { clear = true })
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

g.mapleader = ' '
g.have_nerd_font = true
vim.g.loaded_matchparen = 1
vim.g.autoformat = true

vim.filetype.add({
  extension = {
    conf = 'config',
    njk = 'htmldjango',
    tpl = 'helm',
    ['tsconfig*.json'] = 'jsonc',
  },
  filename = {
    ['.luacheckrc'] = 'lua',
    ['.eslintrc.json'] = 'jsonc',
    ['.envrc'] = 'config',
  },
})

map('x', 'il', 'g_o^', { silent = true })
map('o', 'il', ':normal vil<cr>', { silent = true })
map({ 'n', 'x' }, 'j', 'gj')
map({ 'n', 'x' }, 'k', 'gk')
map({ 'n', 'x' }, '<down>', 'gj')
map({ 'n', 'x' }, '<up>', 'gk')

autocmd('TextYankPost', {
  group = vimRc,
  callback = function()
    vim.highlight.on_yank()
  end,
})
autocmd('FileType', {
  group = vimRc,
  pattern = {
    'fugitive',
    'git',
    'grug-far',
    'help',
    'igit',
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

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- { lazy = true, 'nvim-lua/plenary.nvim' },
  {
    'rose-pine/neovim',
    config = function()
      require('rose-pine').setup({
        variant = 'moon',
        styles = {
          italic = false,
          transparency = false,
        },
      })
      vim.cmd.colorscheme('rose-pine')
    end,
  },
  {
    'basilgood/nvim-sensible',
    opts = { options = { timeoutlen = 2000 } },
  },
  {
    'echasnovski/mini.icons',
    version = false,
    opts = {},
    init = function()
      local mi = require('mini.icons')
      mi.mock_nvim_web_devicons()
      mi.tweak_lsp_kind()
    end,
  },
  { 'monkoose/matchparen.nvim', opts = {} },
  { 'mcauley-penney/visual-whitespace.nvim', opts = {} },
  {
    'hrsh7th/nvim-anydent',
    opts = {},
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          if not vim.tbl_contains({ 'html', 'yaml', 'markdown' }, vim.bo.filetype) then
            require('anydent').attach()
          end
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
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
        'helm',
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
    },
  },
  {
    'bluz71/nvim-linefly',
    init = function()
      g.linefly_options = {
        separator_symbol = '',
        git_branch_symbol = '',
        error_symbol = '',
        warning_symbol = '',
        information_symbol = '',
        with_git_branch = true,
        with_git_status = false,
        with_session_status = false,
        with_macro_status = true,
        with_search_count = false,
        tabline = true,
      }
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    events = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      signs_staged_enable = false,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
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
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    },
  },
  {
    'tpope/vim-fugitive',
    'junegunn/gv.vim',
    'idbrii/vim-mergetool',
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    opts = {
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
    },
    init = function()
      command('ToggleFormat', function()
        vim.g.autoformat = not vim.g.autoformat
        vim.notify(
          string.format('%s formatting...', vim.g.autoformat and 'Enabling' or 'Disabling'),
          vim.log.levels.INFO
        )
      end, { desc = 'Toggle conform.nvim auto-formatting', nargs = 0 })
    end,
  },
  {
    'mfussenegger/nvim-lint',
    config = function()
      local events = { 'BufWritePost', 'BufEnter', 'InsertLeave', 'TextChanged' }
      local linters_by_ft = {
        lua = { 'luacheck' },
        yaml = { 'yamllint' },
        tpl = { 'helm' },
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
    end,
  },
  {
    'dgagn/diagflow.nvim',
    config = function()
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
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.enable({
        'lua_ls',
        'clangd',
        'rust_analyzer',
        'vtsls',
        'eslint',
      })
    end,
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    version = '*',
    opts = {
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
          auto_show = function(ctx)
            return ctx.mode ~= 'cmdline' or not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype())
          end,
        },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        min_keyword_length = function(ctx)
          if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then
            return 3
          end
          return 0
        end,
      },
    },
    opts_extend = { 'sources.default' },
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    opts = {
      picker = {
        enabled = true,
        layout = {
          preset = 'ivy',
        },
      },
      bufdelete = { enabled = true },
      terminal = { enabled = true },
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
    },
    config = function()
      local map = vim.keymap.set
      local command = vim.api.nvim_create_user_command
      local snacks = require('snacks')

      command('Gbrowse', 'lua Snacks.gitbrowse()', {})
      command('Rename', 'lua Snacks.rename.rename_file()', {})
      command('Notifications', 'lua Snacks.notifier.show_history()', {})
      map('n', '<leader>d', snacks.picker.diagnostics_buffer)
      map('n', 'gd', snacks.picker.lsp_definitions)
      map('n', 'grr', snacks.picker.lsp_references)
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
        snacks.picker.files({ hidden = true })
      end)
      map('n', '<bs>', function()
        snacks.picker.buffers({ current = false })
      end)
      map('n', '<leader>g', function()
        snacks.picker.grep({ hidden = true })
      end)
      map('n', '<A-i>', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end)
    end,
  },
  {
    'tpope/vim-vinegar',
    'tpope/vim-repeat',
    'michaeljsmith/vim-indent-object',
    'kkoomen/gfi.vim',
    'sedm0784/vim-resize-mode',
  },
  { 'kylechui/nvim-surround', opts = {} },
  { 'numToStr/Comment.nvim', opts = { { ignore = '^$' } } },
  { 'folke/ts-comments.nvim', opts = {} },
  {
    'smoka7/hop.nvim',
    config = function()
      require('hop').setup({ jump_on_sole_occurrence = true, create_hl_autocmd = false })
      vim.api.nvim_set_hl(0, 'HopUnmatched', { fg = 'NONE' })
      map('n', 's', '<cmd>HopChar1<cr>')
      map('', 'f', '<cmd>HopChar1CurrentLine<cr>')
    end,
  },
  {
    'jake-stewart/normon.nvim',
    config = function()
      local normon = require('normon')
      normon('gs', 'cgn')
      normon('gS', 'cgN')
      normon('*', 'nN', { clearSearch = true })
    end,
  },
  { 'jake-stewart/filestack.nvim', opts = {} },
  {
    'JellyApple102/flote.nvim',
    config = function()
      require('flote').setup({
        notes_dir = os.getenv('HOME') .. '/Notes/',
      })
    end,
  },
  { 'kevinhwang91/nvim-bqf', opts = { preview = { auto_preview = false } } },
  { 'stevearc/quicker.nvim', opts = {} },
  { 'nat-418/boole.nvim', opts = { mappings = { increment = '<C-a>', decrement = '<C-x>' } } },
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
})
