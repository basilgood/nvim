vim.loader.enable()

local g = vim.g
local api = vim.api
local map = vim.keymap.set
local augroup = api.nvim_create_augroup('UserConfig', {})
local autocmd = api.nvim_create_autocmd

-- global
g.mapleader = ' '
g.maplocalleader = '\\'
g.autoformat = true

vim.pack.add({ 'https://github.com/folke/lazy.nvim' }, { confirm = false })

require('lazy').setup({
  {
    'folke/tokyonight.nvim',
    opts = {
      on_highlights = function(hi)
        hi.SnacksIndentScope = { fg = '#3b4261' }
        hi.HopUnmatched = { nocombine = true }
      end,
    },
    init = function()
      vim.cmd.colorscheme('tokyonight')
    end,
  },
  {
    'basilgood/nvim-sensible',
    opts = {
      options = {
        formatexpr = 'v:lua.require("conform").formatexpr()',
      },
    },
    config = function(_, opts)
      require('sensible').setup(opts)

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '\u{ea87}\u{202F}',
            [vim.diagnostic.severity.WARN] = '\u{ea6c}\u{202F}',
            [vim.diagnostic.severity.INFO] = '\u{ea74}\u{202F}',
            [vim.diagnostic.severity.HINT] = '\u{f0335}\u{202F}',
          },
        },
        underline = false,
      })

      map('x', 'il', 'g_o^', { silent = true })
      map('o', 'il', ':<C-u>normal! vil<cr>', { silent = true })
      map('n', 'vv', 'viw')
      map({ 'n', 'x' }, 'j', 'gj')
      map({ 'n', 'x' }, 'k', 'gk')
      map({ 'n', 'x' }, '<down>', 'gj')
      map({ 'n', 'x' }, '<up>', 'gk')
      map({ 'n', 'v' }, '<leader>p', [["+P]])
      map({ 'n', 'v' }, '<leader>y', [["+y]])
      map('n', '<leader>Y', [["+Y]])
      map('n', '<C-s>', function()
        vim.g.skip_formatting = true
        return ':w<cr>'
      end, { expr = true })
      map('n', 'gQ', 'mzgggqG`z<cmd>delmarks z<cr>zz', { desc = 'Format buffer' })
      map('n', '-', function()
        local file = vim.fn.expand('%:t')
        vim.cmd('Explore')
        vim.fn.search('^' .. file .. '$', 'wc')
      end)
      map('n', '[e', function()
        vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
      end)
      map('n', ']e', function()
        vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
      end)
    end,
  },
  {
    'folke/snacks.nvim',
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      indent = {
        enabled = true,
        indent = { enabled = false },
        scope = { enabled = false },
        chunk = { enabled = true },
      },
      scroll = {
        animate = {
          easing = 'inQuad',
        },
      },
      notifier = { enabled = true },
      picker = {
        enabled = true,
        ui_select = true,
        layout = { cycle = false },
      },
      image = {
        backend = 'kitty',
        inline = false,
        doc = {
          enabled = true,
          inline = false,
          float = true,
          max_width = 80,
          max_height = 40,
        },
      },
      input = { enabled = true },
    },
    -- stylua: ignore
    keys = {
      { '<c-p>', function() Snacks.picker.files({ hidden = true }) end },
      { '<bs>', function() Snacks.picker.buffers({ current = false }) end },
      { '<leader>/', function() Snacks.picker.grep({ hidden = true }) end },
      { '<leader>r', function() Snacks.picker.resume() end },
      { '<leader>u', function() Snacks.picker.undo() end },
      { 'z=', function() Snacks.picker.spelling() end },
      { '<leader>nn', function() Snacks.notifier.show_history() end },
      { '<leader>gg', function() Snacks.lazygit() end },
      { '<f1>', function() Snacks.terminal.toggle() end, mode = { 'n', 't' } },
      { '<leader>.', function() Snacks.scratch() end },
      { '<leader>S', function() Snacks.scratch.select() end },
      { '<leader>bd', function() Snacks.bufdelete() end },
      { '<leader>l', function() Snacks.picker() end },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- stylua: ignore
      require('nvim-treesitter').install {
        'astro', 'bash', 'c', 'comment', 'cpp', 'css', 'csv', 'diff',
        'dockerfile', 'git_rebase', 'gitcommit', 'go', 'helm', 'html',
        'http', 'javascript', 'jsdoc', 'json', 'jsx', 'tsx', 'lua',
        'markdown', 'markdown_inline', 'nix', 'regex', 'rust', 'scss',
        'styled', 'terraform', 'toml', 'typescript', 'vim', 'vimdoc', 'yaml',
      }
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
  {
    'hrsh7th/nvim-anydent',
    config = function()
      autocmd('FileType', {
        callback = function()
          if not vim.tbl_contains({ 'html', 'yaml', 'markdown' }, vim.bo.filetype) then
            require('anydent').attach()
          end
        end,
      })
    end,
  },
  {
    'saghen/blink.cmp',
    version = '1.*',
    event = 'InsertEnter',
    dependencies = 'rafamadriz/friendly-snippets',
    opts = {
      keymap = { preset = 'enter' },
      cmdline = { enabled = false },
      completion = {
        ghost_text = { enabled = true },
        accept = { auto_brackets = { enabled = false } },
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        menu = {
          draw = { columns = { { 'label' }, { 'kind_icon' } } },
          scrolloff = 1,
          scrollbar = false,
        },
        list = { selection = { preselect = true, auto_insert = false } },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      snippets = { preset = 'default' },
      -- signature = { enabled = true },
    },
  },
  { 'b0o/SchemaStore.nvim', lazy = true, version = false },
  {
    'junnplus/lsp-setup.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      { 'mason-org/mason.nvim', opts = {} },
      {
        'qvalentin/helm-ls.nvim',
        opts = {
          indent_hints = {
            enable = true,
            filter = function(bufnr)
              local ft = vim.bo[bufnr].filetype
              return ft == 'helm' or ft == 'yaml' or ft:match('yaml')
            end,
          },
        },
      },
    },
    config = function()
      require('lsp-setup').setup({
        default_mappings = false,
        on_attach = function() end,
        servers = {
          lua_ls = {
            settings = {
              Lua = {
                completion = { callSnippet = 'Replace' },
                format = { enable = false },
                hint = {
                  enable = true,
                  arrayIndex = 'Disable',
                },
                runtime = {
                  version = 'LuaJIT',
                },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME,
                    '${3rd}/luv/library',
                  },
                },
              },
            },
          },
          vtsls = { autoUseWorkspaceTsdk = true },
          bashls = {},
          cssls = {},
          nixd = {},
          gopls = {},
          dockerls = {},
          rust_analyzer = {
            settings = {
              ['rust-analyzer'] = {
                check = {
                  command = 'clippy',
                },
              },
            },
          },
          yamlls = {
            capabilities = {
              textDocument = {
                foldingRange = {
                  dynamicRegistration = false,
                  lineFoldingOnly = true,
                },
              },
            },
            before_init = function(_, config)
              config.settings.yaml.schemas =
                vim.tbl_deep_extend('force', config.settings.yaml.schemas or {}, require('schemastore').yaml.schemas())
            end,
            settings = {
              redhat = { telemetry = { enabled = false } },
              yaml = {
                keyOrdering = false,
                format = {
                  enable = true,
                  singleQuote = true,
                },
                validate = true,
                schemaStore = {
                  enable = false,
                  url = '',
                },
              },
            },
          },
          helm_ls = {
            settings = {
              ['helm-ls'] = {
                yamlls = {
                  enabled = true,
                  diagnosticsLimit = 50,
                  showDiagnosticsDirectly = false,
                  path = 'yaml-language-server',
                  config = {
                    schemas = {
                      kubernetes = 'templates/**',
                    },
                    completion = true,
                    hover = true,
                  },
                },
              },
            },
          },
        },
      })
    end,
  },
  { 'esmuellert/nvim-eslint', opts = {} },
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    opts = {
      notify_no_formatters = false,
      formatters = {
        dockerfmt = {
          command = 'dockerfmt',
          args = { '-i', '4' },
        },
      },
      formatters_by_ft = {
        c = { name = 'clangd', timeout_ms = 500, lsp_format = 'prefer' },
        dockerfile = { 'dockerfmt' },
        go = { name = 'gopls', timeout_ms = 500, lsp_format = 'prefer' },
        javascript = { 'prettier', timeout_ms = 500, lsp_format = 'fallback' },
        json = { 'prettier', timeout_ms = 500, lsp_format = 'fallback' },
        jsonc = { 'prettier', timeout_ms = 500, lsp_format = 'fallback' },
        less = { 'prettier' },
        lua = { 'stylua' },
        markdown = { 'prettier' },
        rust = { name = 'rust_analyzer', timeout_ms = 500, lsp_format = 'prefer' },
        scss = { 'prettier' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        nix = { 'nixfmt' },
        typescript = { 'prettier', timeout_ms = 500, lsp_format = 'fallback' },
        yaml = { name = 'yamlls', lsp_format = 'prefer' },
        ['_'] = { 'trim_whitespace', 'trim_newlines' },
      },
      format_on_save = function()
        if vim.g.skip_formatting then
          vim.g.skip_formatting = false
          return nil
        end

        if not vim.g.autoformat then
          return nil
        end

        return {}
      end,
    },
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      events = { 'BufEnter', 'BufWritePost', 'TextChanged', 'InsertLeave' },
      linters_by_ft = {
        lua = { 'luacheck' },
        bash = { 'shellcheck' },
        sh = { 'shellcheck' },
        json = { 'jq' },
        dockerfile = { 'hadolint' },
      },
      linters = {
        luacheck = {
          prepend_args = { '--globals', 'vim' },
        },
      },
    },
    config = function(_, opts)
      local lint = require('lint')

      for name, linter in pairs(opts.linters) do
        if type(linter) == 'table' and type(lint.linters[name]) == 'table' then
          lint.linters[name] = vim.tbl_deep_extend('force', lint.linters[name], linter)
          if type(linter.prepend_args) == 'table' then
            lint.linters[name].args = lint.linters[name].args or {}
            vim.list_extend(lint.linters[name].args, linter.prepend_args)
          end
        else
          lint.linters[name] = linter
        end
      end

      lint.linters_by_ft = opts.linters_by_ft

      autocmd(opts.events, {
        group = augroup,
        callback = function()
          lint.try_lint(nil, { ignore_errors = true })
        end,
      })
    end,
  },
  {
    'ofirgall/diagflow.nvim',
    event = 'BufReadPre',
    opts = {
      scope = 'line',
      toggle_event = { 'InsertEnter', 'InsertLeave' },
    },
  },
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  { 'MunifTanjim/nui.nvim', lazy = true },
  {
    'folke/trouble.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>cs', '<cmd>Trouble symbols toggle<cr>', desc = 'Symbols (Trouble)' },
      { '<leader>cl', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP Definitions (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Previous Trouble/Quickfix Item',
      },
      {
        ']q',
        function()
          if require('trouble').is_open() then
            require('trouble').next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Next Trouble/Quickfix Item',
      },
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = 'mini',
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  -- stylua: ignore
  keys = {
    { '<leader>nl', function() require('noice').cmd('last') end, desc = 'Noice Last Message' },
    { '<leader>nh', function() require('noice').cmd('history') end, desc = 'Noice History' },
    { '<leader>na', function() require('noice').cmd('all') end, desc = 'Noice All' },
    { '<leader>nd', function() require('noice').cmd('dismiss') end, desc = 'Dismiss All' },
    { '<leader>np', function() require('noice').cmd('pick') end, desc = 'Noice Picker (Telescope/FzfLua)' },
    { '<c-f>', function() if not require('noice.lsp').scroll(4) then return '<c-f>' end end, silent = true, expr = true, desc = 'Scroll Forward', mode = {'i', 'n', 's'} },
    { '<c-b>', function() if not require('noice.lsp').scroll(-4) then return '<c-b>' end end, silent = true, expr = true, desc = 'Scroll Backward', mode = {'i', 'n', 's'}},
  },
    config = function(_, opts)
      if vim.o.filetype == 'lazy' then
        vim.cmd([[messages clear]])
      end
      require('noice').setup(opts)
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '┊' },
        change = { text = '┊' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '┊' },
        untracked = { text = '┆' },
      },
      signs_staged_enable = false,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gs.nav_hunk('next')
          end
        end, { buffer = buffer })
        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gs.nav_hunk('prev')
          end
        end, { buffer = buffer })
        map('n', ']H', function()
          gs.nav_hunk('last')
        end, { buffer = buffer })
        map('n', '[H', function()
          gs.nav_hunk('first')
        end, { buffer = buffer })
        map('n', 'ghp', gs.preview_hunk, { buffer = buffer })
        map('n', 'ghP', gs.preview_hunk_inline, { buffer = buffer })
        map('n', 'ghr', gs.reset_hunk, { buffer = buffer })
        map('n', 'ghb', gs.toggle_current_line_blame, { buffer = buffer })
        map('n', 'ghB', function()
          gs.blame()
        end, { buffer = buffer })
        map('n', 'ghd', gs.diffthis, { buffer = buffer })
        map('n', 'ghD', function()
          gs.diffthis('~')
        end, { buffer = buffer })
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { buffer = buffer })
      end,
    },
  },
  {
    'esmuellert/codediff.nvim',
    lazy = true,
    cmd = 'CodeDiff',
  },
  {
    'clabby/difftastic.nvim',
    opts = {
      download = true,
      vcs = 'git',
      snacks_picker = {
        enabled = true,
      },
    },
  },
  {
    'NeogitOrg/neogit',
    lazy = true,
    cmd = 'Neogit',
    keys = { { '<leader>gn', ':Neogit<cr>' } },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'spacedentist/resolve.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
  {
    'smoka7/hop.nvim',
    opts = { jump_on_sole_occurrence = true, create_hl_autocmd = false },
    keys = { { 's', '<cmd>HopChar1<cr>' } },
  },
  { 'numToStr/Comment.nvim', opts = { ignore = '^%s*$' } },
  { 'kylechui/nvim-surround', opts = {} },
  { 'windwp/nvim-ts-autotag', opts = {} },
  { 'yochem/jq-playground.nvim', cmd = 'JQ' },
  { 'stevearc/quicker.nvim', opts = {}, ft = 'qf' },
  {
    'kevinhwang91/nvim-bqf',
    opts = { preview = { auto_preview = false, winblend = 0 }, auto_resize = true },
    ft = 'qf',
  },
  { 'haya14busa/vim-asterisk', event = 'BufReadPost', keys = { { '*', '<Plug>(asterisk-z*)', mode = { 'n', 'x' } } } },
  { 'mnjm/topline.nvim', opts = {}, event = 'BufReadPost' },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      heading = {
        sign = false,
        icons = {},
      },
      code = {
        sign = false,
        width = 'block',
        right_pad = 1,
      },
    },
    ft = { 'markdown', 'norg', 'rmd', 'org', 'codecompanion' },
    config = function(_, opts)
      require('render-markdown').setup(opts)
    end,
  },
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
    -- stylua: ignore
    keys = {
      { '<leader>ss', function() require('persistence').load() end, desc = 'Restore Session' },
    },
  },
}, {})
