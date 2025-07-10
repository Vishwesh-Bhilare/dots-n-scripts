-- Set leader key early
vim.g.mapleader = " "

-- Load lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Core modules
require("options")
require("keymaps")

-- Plugins
require("plugins")
require("plugins.lsp")
require("plugins.cmp")
require("plugins.none_ls")
require("plugins.treesitter")
require("plugins.autopairs")
require("plugins.scrollbar")
require("plugins.telescope")
require("plugins.nvim_tree")
require("plugins.lualine")
require("plugins.which_key")
require("config.starter")

-- Theme
vim.cmd.colorscheme "catppuccin-mocha"
