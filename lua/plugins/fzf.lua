return {
  'ibhagwan/fzf-lua',
  config = function()
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
  end,
  cmd = 'FzfLua',
  keys = {
    {
      '<c-p>',
      '<cmd>lua require("fzf-lua").files({ cmd = "fd -tf -tl -H -E=.git -E=node_modules --strip-cwd-prefix" })<cr>',
    },
    { '<bs>', '<cmd>FzfLua buffers<cr>' },
    { '<leader>g', '<cmd>FzfLua live_grep_glob<cr>' },
    { '<leader>w', '<cmd>FzfLua grep_cword<cr>' },
    { '<leader>w', '<cmd>FzfLua grep_visual<cr>', mode = { 'x' } },
    { '<leader>o', '<cmd>FzfLua oldfiles<cr>' },
    { '<leader>h', '<cmd>FzfLua help_tags<cr>' },
    { '<leader>r', '<cmd>FzfLua resume<cr>' },
    {
      'z=',
      function()
        require('fzf-lua').spell_suggest({
          winopts = { relative = 'cursor', row = 1.01, col = 0, height = 0.2, width = 0.5 },
        })
      end,
    },
    {
      'gd',
      function()
        require('fzf-lua').lsp_definitions({ jump_to_single_result = true })
      end,
    },
    { 'gD', '<cmd>FzfLua lsp_definitions<cr>' },
    { 'gr', '<cmd>FzfLua lsp_references<cr>' },
    { 'gy', '<cmd>FzfLua lsp_implementations<cr>' },
    { '<f4>', '<cmd>FzfLua lsp_code_actions<cr>' },
    { '<leader>d', '<cmd>FzfLua diagnostics_document<cr>' },
  },
}
