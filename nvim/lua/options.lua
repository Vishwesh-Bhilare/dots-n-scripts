vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true

-- Clipboard
vim.opt.clipboard = 'unnamedplus'
vim.opt.clipboard:append("unnamedplus")
vim.keymap.set('i', '<C-v>', '<C-r>+', { noremap = true, desc = 'Paste from clipboard' })
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true, desc = 'Copy to clipboard' })
