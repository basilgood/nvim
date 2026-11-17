return {
  'MeanderingProgrammer/render-markdown.nvim',
  opts = {
    file_types = { 'markdown' },
    -- heading = {
    --   sign = false,
    --   icons = {},
    -- },
    code = {
      sign = false,
      width = 'block',
      right_pad = 1,
    },
  },
  ft = { 'markdown', 'norg', 'rmd', 'org' },
  config = function(_, opts)
    require('render-markdown').setup(opts)
  end,
}
