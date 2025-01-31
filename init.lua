-- init.lua
vim.loader.enable()

local pckr_path = vim.fn.stdpath('data') .. '/pckr/pckr.nvim'

---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(pckr_path) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/lewis6991/pckr.nvim',
    pckr_path,
  })
end

local g = vim.g
g.mapleader = ' '
g.maplocalleader = ' '
g.have_nerd_font = true

local map = vim.keymap.set
local vimRc = vim.api.nvim_create_augroup('vimRc', { clear = true })
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

vim.opt.rtp:prepend(pckr_path)

local pckr = require('pckr')
local cmd = require('pckr.loader.cmd')

pckr.add({
  {
    'folke/snacks.nvim',
    requires = { 'basilgood/nvim-sensible', 'mcauley-penney/visual-whitespace.nvim' },
    config = function()
      local snacks = require('snacks')
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
        picker = {
          enabled = true,
          layout = { cycle = false, preview = false, preset = 'vertical' },
        },
        lazygit = { enabled = true },
        gitbrowse = { enabled = true },
        input = { enabled = true },
        scroll = {
          enabled = true,
          animate = {
            duration = { step = 10, total = 150 },
            easing = 'linear',
          },
          spamming = 10,
        },
        animate = {
          enabled = true,
          duration = 20,
          easing = 'linear',
          fps = 60,
        },
      })
      map('n', '<c-p>', function()
        Snacks.picker.files({ hidden = true })
      end)
      map('n', '<bs>', function()
        Snacks.picker.buffers({ current = false })
      end)
      map('n', '<leader>g', function()
        Snacks.picker.grep({ hidden = true })
      end)
      map('n', '<leader>d', snacks.picker.diagnostics_buffer)
      map('n', 'gd', snacks.picker.lsp_definitions)
      map('n', 'gr', snacks.picker.lsp_references)
      map('n', '<f5>', snacks.lazygit.open)
      map('n', 'ghL', snacks.lazygit.log_file)
      map('n', '<leader>nn', snacks.scratch.open)
      map('n', '<leader>ns', snacks.scratch.select)
      map('n', 'z=', snacks.picker.spelling)

      command('Gbrowse', 'lua Snacks.gitbrowse()', {})
      command('Rename', 'lua Snacks.rename.rename_file()', {})
      command('Notifications', 'lua Snacks.notifier.show_history()', {})
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

      require('sensible').setup({
        options = { list = false, statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]] },
      })
      require('visual-whitespace').setup()

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
          map('n', 'P', '<cmd>wincmd w|bw<cr><cmd>close<cr>', opts)
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
          'git',
          'fugitive',
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
      autocmd({ 'FocusGained', 'WinEnter', 'TermClose', 'TermLeave' }, {
        command = "if getcmdwintype() == '' | checktime | endif",
      })
    end,
  },

  {
    'rebelot/kanagawa.nvim',
    config = function()
      require('kanagawa').setup({
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = 'none',
              },
            },
          },
        },
        overrides = function()
          return {
            Boolean = { bold = false },
          }
        end,
      })
      vim.cmd.colorscheme('kanagawa')
    end,
  },

  {
    'rachartier/tiny-inline-diagnostic.nvim',
    config = function()
      vim.diagnostic.config({
        virtual_text = false,
        underline = false,
        float = {
          border = 'single',
          header = '',
          source = true,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.WARN] = '',
          },
        },
      })
      map('n', 'gl', vim.diagnostic.open_float)
      require('tiny-inline-diagnostic').setup()
    end,
  },

  {
    'yioneko/nvim-yati',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
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
    end,
  },
  {

    'Saghen/blink.cmp',
    tag = 'v*',
    requires = {
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require('blink.cmp').setup({
        keymap = { preset = 'enter', ['<c-l>'] = { 'show', 'show_documentation', 'hide_documentation' } },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
          cmdline = {},
        },
        completion = {
          documentation = { auto_show = true },
          list = { selection = { auto_insert = false } },
        },
      })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    requires = {
      'saghen/blink.cmp',
      'yioneko/nvim-vtsls',
      'marilari88/twoslash-queries.nvim',
      'saecki/live-rename.nvim',
    },
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.util.default_config = vim.tbl_deep_extend('force', lspconfig.util.default_config, {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })

      -- typescript ^?
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
              },
              checkThirdParty = false,
            },
          },
        },
      })

      map('i', '<c-k>', vim.lsp.buf.signature_help, { desc = 'show signature' })
      map('n', '<f2>', require('live-rename').rename)
      map(
        'n',
        '<f4>',
        ':lua vim.lsp.buf.code_action({ context = { only = { "source", "refactor", "quickfix" } } })<cr>'
      )
    end,
  },

  {
    'mfussenegger/nvim-lint',
    config = function()
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
    end,
  },

  {
    'stevearc/conform.nvim',
    config = function()
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
          ['_'] = { 'trim_whitespace', 'trim_newlines' },
        },
      })
      map({ 'n', 'v' }, 'Q', function()
        conform.format({
          async = false,
          lsp_fallback = true,
          timeout_ms = 2000,
        })
        vim.cmd('update')
      end)
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    requires = {
      'tpope/vim-fugitive',
      'tpope/vim-rhubarb',
      'idanarye/vim-merginal',
      'junegunn/gv.vim',
      'sodapopcan/vim-twiggy',
      'akinsho/git-conflict.nvim',
    },
    config = function()
      require('git-conflict').setup()
      local gs = require('gitsigns')
      gs.setup({
        signs = {
          add = { text = '╎' },
          change = { text = '╎' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
          untracked = { text = '┆' },
        },
        signs_staged = {
          add = { text = '┊' },
        },
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
      map('n', 'ghg', '<cmd>tab G<cr>')
      map('n', 'ghd', '<cmd>Gvdiffsplit!<cr>')
      map('n', 'ghl', '<cmd>GV --all<cr>')
      map('n', 'ght', '<cmd>GV --no-graph --no-walk --tags<cr>')
    end,
  },

  {
    'ojroques/nvim-hardline',
    requires = { 'crispgm/nvim-tabline', 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('hardline').setup({
        bufferline = false,
        -- theme = 'jellybeans',
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
      require('tabline').setup({})
    end,
  },

  {
    'OXY2DEV/markview.nvim',
    requires = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },

  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    run = ':call mkdp#util#install()',
  },

  {
    'tpope/vim-repeat',
    requires = {
      'nvim-lua/plenary.nvim',
      'kkoomen/gfi.vim',
      'kylechui/nvim-surround',
      'smoka7/hop.nvim',
      'numToStr/Comment.nvim',
      'folke/ts-comments.nvim',
      'nvim-pack/nvim-spectre',
      'loqusion/star.nvim',
      'echasnovski/mini.hipatterns',
      'nat-418/boole.nvim',
      'kevinhwang91/nvim-bqf',
      'echasnovski/mini.bufremove',
    },
    config = function()
      require('hop').setup({ jump_on_sole_occurrence = true, create_hl_autocmd = false })
      vim.api.nvim_set_hl(0, 'HopUnmatched', { fg = 'NONE' })
      map('n', 's', '<cmd>HopChar1<cr>')
      map('', 'f', '<cmd>HopChar1CurrentLine<cr>')

      require('nvim-surround').setup()

      require('Comment').setup({ ignore = '^$' })

      require('ts-comments').setup({})

      require('star').setup({ auto_map = false })
      map({ 'n', 'x' }, '*', function()
        require('star').star('star')
      end)
      map({ 'n', 'x' }, 'gs', function()
        require('star').star('star')
        vim.api.nvim_feedkeys('cgn', 'nt', true)
      end)

      require('mini.hipatterns').setup({
        highlighters = {
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
          hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
        },
      })

      require('mini.bufremove').setup()
      map('n', '<c-w>d', '<cmd>lua MiniBufremove.delete()<cr>')

      require('boole').setup({
        mappings = { increment = '<C-a>', decrement = '<C-x>' },
      })

      require('bqf').setup({
        preview = { auto_preview = false },
      })
    end,
  },

  {
    'folke/persistence.nvim',
    config = function()
      require('persistence').setup({
        options = vim.opt.sessionoptions:get(),
      })
      map('n', '<leader>s', function()
        require('persistence').load()
      end)
    end,
  },
})
