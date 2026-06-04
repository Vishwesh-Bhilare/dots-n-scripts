-- mappings, including plugins
local run = require("run")

local function map(m, k, v)
	vim.keymap.set(m, k, v, { noremap = true, silent = true })
end

-- set leader
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")
map("n", "<leader>q", ":BufferClose<CR>")
map("n", "<leader>Q", ":BufferClose!<CR>")
map("n", "<leader>U", "::bufdo bd<CR>") --close all
map('n', '<leader>vs', ':vsplit<CR>:bnext<CR>') --ver split + open next buffer

-- buffer position nav + reorder
map('n', '<AS-h>', '<Cmd>BufferMovePrevious<CR>')
map('n', '<AS-l>', '<Cmd>BufferMoveNext<CR>')
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>')
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>')
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>')
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>')
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>')
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>')
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>')
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>')
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>')
map('n', '<A-0>', '<Cmd>BufferLast<CR>')
map('n', '<A-p>', '<Cmd>BufferPin<CR>')

-- windows - ctrl nav, fn resize
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<F5>", ":resize +2<CR>")
map("n", "<F6>", ":resize -2<CR>")
map("n", "<F7>", ":vertical resize +2<CR>")
map("n", "<F8>", ":vertical resize -2<CR>")

-- fzf and grep
map("n", "<leader>f", ":lua require('fzf-lua').files()<CR>") --search cwd
map("n", "<leader>Fh", ":lua require('fzf-lua').files({ cwd = '~/' })<CR>") --search home
map("n", "<leader>Fc", ":lua require('fzf-lua').files({ cwd = '~/.config' })<CR>") --search .config
map("n", "<leader>Fl", ":lua require('fzf-lua').files({ cwd = '~/.local/src' })<CR>") --search .local/src
map("n", "<leader>Ff", ":lua require('fzf-lua').files({ cwd = '..' })<CR>") --search above
map("n", "<leader>Fr", ":lua require('fzf-lua').resume()<CR>") --last search
map("n", "<leader>g", ":lua require('fzf-lua').grep()<CR>") --grep
map("n", "<leader>G", ":lua require('fzf-lua').grep_cword()<CR>") --grep word under cursor

-- CLIPBOARD - COPY FROM NEOVIM TO OUTSIDE
-- Visual mode: copy selected text to clipboard
map("v", "<leader>y", '"+y')
map("v", "<C-c>", '"+y')  -- Ctrl+C like other editors

-- Normal mode: copy to clipboard
map("n", "<leader>yy", '"+yy')  -- Copy current line
map("n", "<leader>Y", '"+y$')   -- Copy to end of line
map("n", "<leader>ya", ':%y+<CR>')  -- Copy entire file

-- Paste from clipboard to Neovim
map("n", "<leader>p", '"+p')  -- Paste after cursor
map("n", "<leader>P", '"+P')  -- Paste before cursor
map("i", "<C-v>", '<C-r>+')   -- Ctrl+V in insert mode

-- Cut to clipboard
map("v", "<leader>x", '"+x')   -- Cut selected text
map("n", "<leader>xx", '"+dd') -- Cut current line

-- Delete without copying (black hole register)
map("n", "<leader>d", '"_d')
map("v", "<leader>d", '"_d')

-- Primary selection (X11 middle-click)
map("v", "<leader>m", '"*y')  -- Copy to primary selection
map("n", "<leader>m", '"*yy') -- Copy line to primary

-- misc
map("n", "<leader>s", ":%s//g<Left><Left>") --replace all
map("n", "<leader>t", ":NvimTreeToggle<CR>") --open file explorer
map("n", "<leader>P", ":PlugInstall<CR>") --vim-plug
map('n', '<leader>z', ":lua require('FTerm').open()<CR>") --open term
map('t', '<Esc>', '<C-\\><C-n><CMD>lua require("FTerm").close()<CR>') --preserves session
map("n", "<leader>w", ":w<CR>") --write but one less key
map("n", "<leader>dd", ":w ") --duplicate to new name
map("n", "<leader>x", "<cmd>!chmod +x %<CR>") --make a file executable
map("n", "<leader>mv", ":!mv % ") --move a file to a new dir
map("n", "<leader>R", ":so %<CR>") --reload neovim config
map("n", "<leader>u", ':silent !xdg-open "<cWORD>" &<CR>') --open a url under cursor
map("v", "<leader>i", "=gv") --auto indent
map("n", "<leader>W", ":set wrap!<CR>") --toggle wrap
map("n", "<leader>l", ":Twilight<CR>") --surrounding dim

-- decisive csv
map("n", "<leader>csa", ":lua require('decisive').align_csv({})<cr>")
map("n", "<leader>csA", ":lua require('decisive').align_csv_clear({})<cr>")
map("n", "[c", ":lua require('decisive').align_csv_prev_col()<cr>")
map("n", "]c", ":lua require('decisive').align_csv_next_col()<cr>")


map("n", "<leader>H", function() --toggle htop in term
    _G.htop:toggle()
end)


map("n", "<leader>ma", function() --quick make in dir of buffer
	local bufdir = vim.fn.expand("%:p:h")
	vim.cmd("lcd " .. bufdir)
	vim.cmd("!sudo make uninstall && sudo make clean install %")
end)


map("n", "<leader>nn", function() --toggle relative vs absolute line numbers
	if vim.wo.relativenumber then
		vim.wo.relativenumber = false
		vim.wo.number = true
	else
		vim.wo.relativenumber = true
	end
end)

-- Run current file in floating window
map("n", "<leader>r", function() 
    require("run").run_file() 
end)

-- Run in split terminal (alternative)
map("n", "<leader>R", function()
    require("run").run_in_terminal()
end)

-- Debug current file
map("n", "<leader>D", function()
    require("run").debug_file()
end)

-- Compile only
map("n", "<leader>cc", function()
    vim.cmd("w")
    local filetype = vim.bo.filetype
    local filename = vim.fn.expand("%:p")
    local filename_no_ext = vim.fn.expand("%:r")
    
    if filetype == "c" then
        vim.cmd("term gcc -o " .. vim.fn.shellescape(filename_no_ext) .. "_out " .. vim.fn.shellescape(filename))
    elseif filetype == "cpp" then
        vim.cmd("term g++ -std=c++17 -o " .. vim.fn.shellescape(filename_no_ext) .. "_out " .. vim.fn.shellescape(filename))
    elseif filetype == "java" then
        vim.cmd("term javac " .. vim.fn.shellescape(filename))
    else
        print("Compile only supported for C/C++/Java")
    end
end)