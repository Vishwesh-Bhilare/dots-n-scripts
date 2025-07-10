vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')

vim.keymap.set('n', '<leader>r', function()
  local ft = vim.bo.filetype
  local filename = vim.fn.expand("%")
  local cmd = ""
  if ft == "python" then
    cmd = "python " .. filename
  elseif ft == "cpp" or ft == "c" then
    local output = vim.fn.expand("%:r")
    local compiler = ft == "cpp" and "g++" or "gcc"
    cmd = string.format("%s %s -o %s && ./%s", compiler, filename, output, output)
  else
    print("Unsupported filetype: " .. ft)
    return
  end
  vim.cmd("split | terminal " .. cmd)
end, { noremap = true, silent = true })

vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<leader>q', '<C-\\><C-n>:q<CR>', { noremap = true, silent = true })
