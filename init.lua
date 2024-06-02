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
local o = vim.opt
local vimRc = vim.api.nvim_create_augroup('vimRc', { clear = true })
local autocmd = vim.api.nvim_create_autocmd
local success, config = pcall(require, 'config')

if (success and type(config) == 'function') or not success then
  -- options
  now(function()
    o.swapfile = false
    o.shiftwidth = 2
    o.tabstop = 2
    o.expandtab = true
    o.gdefault = true
    o.number = true
    o.wrap = false
    o.linebreak = true
    o.breakindent = true
    o.splitbelow = true
    o.splitright = true
    o.splitkeep = 'screen'
    o.undofile = true
    o.autowrite = true
    o.autowriteall = true
    o.confirm = true
    o.signcolumn = 'yes'
    o.numberwidth = 3
    o.cursorlineopt = 'number'
    o.statuscolumn = '%s%{v:lnum}'
    o.cursorline = true
    o.updatetime = 300
    o.timeoutlen = 2000
    o.ttimeoutlen = 10
    o.completeopt = 'menuone,noselect,noinsert'
    o.complete:remove('t')
    o.pumheight = 5
    o.showmode = false
    o.wildmode = 'longest:full,full'
    -- opt.diffopt = 'internal,filler,closeoff,context:3,indent-heuristic,algorithm:patience,linematch:60'
    o.diffopt = {
      'internal',
      'filler',
      'closeoff',
      'hiddenoff',
      'algorithm:minimal',
    }
    o.sessionoptions = 'buffers,curdir,tabpages,folds,winpos,winsize'
    o.list = true
    o.listchars = { lead = '⋅', trail = '⋅', tab = '▏ ', nbsp = '␣', precedes = '◀', extends = '▶' }
    o.shortmess:append({
      I = true,
      w = true,
      s = true,
    })
    o.fillchars = {
      eob = ' ',
      diff = ' ',
    }
    o.grepprg = 'rg --color=never --vimgrep'
    o.grepformat = '%f:%l:%c:%m'
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
        vim.keymap.set('n', 'q', '<cmd>quit<cr>', { buffer = args.buf })
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

  -- colorscheme
  now(function()
    vim.o.termguicolors = true
    add('HoNamDuong/hybrid.nvim')
    add('mikesmithgh/gruvsquirrel.nvim')
    add('ramojus/mellifluous.nvim')
    add('gmr458/vscode_modern_theme.nvim')
    require('vscode_modern').setup({
      cursorline = true,
      transparent_background = false,
      nvim_tree_darker = true,
    })
    vim.cmd.colorscheme('mellifluous')
  end)

  -- statusline
  now(function()
    o.statusline =
      ' %{mode()} | %{expand("%:p:h:t")}/%t %#search#%{&modified?" ":""}%* %r %= %{&filetype} | %4c:%l/%L'
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
          winhighlight = 'FloatBorder:Whitespace',
          col_offset = 0,
          side_padding = 0,
        },
        documentation = {
          border = 'single',
          winhighlight = 'FloatBorder:Whitespace',
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
    vim.lsp.handlers['textDocument/signatureHelp'] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
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
        'rbong/vim-flog',
      },
    })
    if vim.fn.executable('nvr') == 1 then
      vim.env.GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=delete'"
    end
    vim.g.flog_permanent_default_opts = {
      date = 'short',
    }
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
  end)

  -- telescope
  later(function()
    add({
      source = 'nvim-telescope/telescope.nvim',
      depends = {
        'nvim-telescope/telescope-file-browser.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim',
        'echasnovski/mini.fuzzy',
      },
    })
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local lga_actions = require('telescope-live-grep-args.actions')
    local live_grep_args_shortcuts = require('telescope-live-grep-args.shortcuts')
    require('mini.fuzzy').setup()

    local function filenameFirst(_, path)
      local tail = vim.fs.basename(path)
      local parent = vim.fs.dirname(path)
      if parent == '.' then
        return tail
      end
      return string.format('%s\t\t%s', tail, parent)
    end

    telescope.setup({
      defaults = {
        path_display = { 'smart' },
        selection_strategy = 'reset',
        scroll_strategy = 'limit',
        dynamic_preview_title = true,
        selection_caret = '➤ ',
        prompt_prefix = '➤ ',
        mappings = {
          i = {
            ['<Esc>'] = actions.close,
            ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
            ['<C-s>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-Down>'] = actions.cycle_history_next,
            ['<C-Up>'] = actions.cycle_history_prev,
          },
        },
      },
      pickers = {
        live_grep = {
          theme = 'dropdown',
        },
        grep_string = {
          theme = 'dropdown',
        },
        find_files = {
          find_command = {
            'fd',
            '-tf',
            '-tl',
            '-H',
            '-E=node_modules',
            '-E=.git',
            '--strip-cwd-prefix',
          },
          theme = 'dropdown',
          previewer = true,
          path_display = filenameFirst,
        },
        buffers = {
          theme = 'dropdown',
          previewer = true,
          initial_mode = 'normal',
          mappings = {
            i = {
              ['<c-x>'] = actions.delete_buffer,
            },
            n = {
              ['dd'] = actions.delete_buffer,
            },
          },
        },
        oldfiles = {
          theme = 'dropdown',
          path_display = filenameFirst,
        },
        help_tags = {
          theme = 'dropdown',
        },
        colorscheme = {
          enable_preview = true,
        },
        lsp_references = {
          theme = 'dropdown',
          initial_mode = 'normal',
        },
        lsp_definitions = {
          theme = 'dropdown',
          initial_mode = 'normal',
        },
        lsp_declarations = {
          theme = 'dropdown',
          initial_mode = 'normal',
        },
        lsp_implementations = {
          theme = 'dropdown',
          initial_mode = 'normal',
        },
        diagnostics = {
          theme = 'dropdown',
          initial_mode = 'normal',
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        live_grep_args = {
          auto_quoting = false,
          theme = 'dropdown',
          mappings = { -- extend mappings
            i = {
              ['<C-k>'] = lga_actions.quote_prompt(),
              ['<C-g>'] = lga_actions.quote_prompt({ postfix = ' -g ' }),
            },
          },
        },
      },
    })
    telescope.load_extension('ui-select')
    telescope.load_extension('live_grep_args')
    local opts = { noremap = true, silent = true }
    map('n', '<c-p>', '<cmd>Telescope find_files<cr>')
    map('n', '<bs>', '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>')
    map('n', '<leader>g', "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>")
    map('n', '<leader>w', live_grep_args_shortcuts.grep_word_under_cursor)
    map('x', '<leader>w', live_grep_args_shortcuts.grep_visual_selection)
    map('n', '<leader>o', '<cmd>Telescope oldfiles<cr>')
    map('n', '<leader>h', '<cmd>Telescope help_tags<cr>')

    map('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
    map('n', 'gy', '<cmd>Telescope lsp_implementations<CR>', opts)
    map('n', 'gT', '<cmd>Telescope lsp_type_definitions<CR>', opts)
    map('n', '<leader>d', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)
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
end
