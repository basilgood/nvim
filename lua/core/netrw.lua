local g = vim.g
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command
local map = vim.keymap.set

g.netrw_list_hide = '^./$,^../$'
g.netrw_bufsettings = 'noma nomod nonu nobl nowrap ro nocul scl=no'
g.netrw_banner = 0
g.netrw_sizestyle = 'H'
g.netrw_preview = 1
g.netrw_alto = 'spr'
g.netrw_use_errorwindow = 0
g.netrw_special_syntax = 1
g.netrw_localcopydircmd = 'cp -r'
g.netrw_localrmdir = 'rm -r'
g.netrw_localmkdir = 'mkdir -p'

map('n', '-', function()
  local file = vim.fn.expand('%:t')
  vim.fn.execute('Explore')
  vim.fn.search(file, 'wc')
end)

autocmd('filetype', {
  pattern = 'netrw',
  callback = function()
    local opts = { buffer = true, remap = true }
    map('n', '<tab>', 'mf', opts)
    map('n', '<esc>', 'mF', opts)
    map('n', '.', 'mfmx', opts)
    map('n', 'P', '<cmd>wincmd w|bd|wincmd c<cr>', opts)
  end,
})

command('Rename', function()
  local old_name = vim.fn.expand('%')
  local new_name = vim.fn.input('New file name: ', old_name, 'file')
  if new_name ~= '' and new_name ~= old_name then
    vim.cmd(':saveas! ' .. new_name)
    vim.cmd(':silent !rm ' .. old_name)
    vim.cmd(':silent bd ' .. old_name)
    vim.cmd('redraw!')
  end
end, { nargs = 0 })
