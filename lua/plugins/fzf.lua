return {
  'ibhagwan/fzf-lua',
  opts = {
    winopts = {
      width = 0.7,
      preview = { layout = 'vertical', vertical = 'up:60%' },
    },
  },
  cmd = 'FzfLua',
  keys = {
    {
      '<c-p>',
      '<cmd>lua require("fzf-lua").files({ cmd = "fd -tf -L -H -E=.git -E=node_modules --strip-cwd-prefix" })<cr>',
    },
    { '<bs>', '<cmd>lua require("fzf-lua").buffers()<cr>' },
    { '<leader>g', '<cmd>lua require("fzf-lua").grep({ search = "" })<cr>' },
    { '<leader>w', '<cmd>lua require("fzf-lua").grep_cword()<cr>' },
    { '<leader>w', '<cmd>lua require("fzf-lua").grep_visual()<cr>' },
    { '<leader>o', '<cmd>lua require("fzf-lua").oldfiles()<cr>' },
    { '<leader>h', '<cmd>lua require("fzf-lua").help_tags()<cr>' },
    {
      'gd',
      function()
        require('fzf-lua').lsp_definitions({ jump_to_single_result = true })
      end,
    },
    { 'gD', '<cmd>FzfLua lsp_definitions<cr>' },
    { 'gr', '<cmd>FzfLua lsp_references<cr>' },
    { 'gy', '<cmd>FzfLua lsp_implementations<cr>' },
    -- { '<f4>', '<cmd>lua vim.lsp.buf.code_action()<cr>' },
    { '<leader>d', '<cmd>FzfLua diagnostics_document<cr>' },
  },
}
