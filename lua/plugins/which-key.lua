local wk = require("which-key")
wk.add({
-- Clipboard bindings
{ "<leader>y", desc = "yank selection to clipboard" },
{ "<leader>yy", desc = "yank line to clipboard" },
{ "<leader>Y", desc = "yank to EOL to clipboard" },
{ "<leader>ya", desc = "yank entire file to clipboard" },
{ "<leader>p", desc = "paste from clipboard after cursor" },
{ "<leader>P", desc = "paste from clipboard before cursor" },
{ "<leader>x", desc = "cut selection to clipboard" },
{ "<leader>xx", desc = "cut line to clipboard" },
{ "<leader>d", desc = "delete without copying" },
{ "<leader>m", desc = "copy to X11 primary (middle-click)" },

-- File operations
{ "<leader>w", desc = "write/save file" },
{ "<leader>dd", desc = "duplicate file" },
{ "<leader>x", desc = "chmod +x" },
{ "<leader>mv", desc = "move file" },

-- Navigation
{ "<leader>t", desc = "toggle file explorer" },
{ "<leader>vs", desc = "vsplit next buffer" },
{ "<leader>f", desc = "fzf search files" },
{ "<leader>g", desc = "grep search" },
{ "<leader>G", desc = "grep word under cursor" },

-- Buffer management
{ "<leader>q", desc = "close buffer" },
{ "<leader>Q", desc = "force close buffer" },
{ "<leader>U", desc = "close all buffers" },

-- Appearance
{ "<leader>p", desc = "toggle theme" },
{ "<leader>W", desc = "toggle wrap" },
{ "<leader>nn", desc = "toggle relative numbers" },
{ "<leader>l", desc = "toggle twilight (surrounding dim)" },

-- Tools
{ "<leader>z", desc = "floating terminal" },
{ "<leader>H", desc = "htop terminal" },
{ "<leader>u", desc = "open URL under cursor" },
{ "<leader>R", desc = "reload neovim config" },
{ "<leader>P", desc = "install plugins" },

-- Code execution
{ "<leader>r", desc = "run file (floating window)" },
{ "<leader>R", desc = "run file (split terminal)" },
{ "<leader>cc", desc = "compile C/C++/Java" },
{ "<leader>D", desc = "debug file" },
{ "<leader>ma", desc = "make install in buffer dir" },

-- Search variants
{ "<leader>Fh", desc = "fzf search home" },
{ "<leader>Fc", desc = "fzf search .config" },
{ "<leader>Fl", desc = "fzf search .local/src" },
{ "<leader>Ff", desc = "fzf search parent dir" },
{ "<leader>Fr", desc = "resume last fzf search" },

-- Text operations
{ "<leader>s", desc = "search and replace" },
{ "<leader>i", desc = "auto indent selection" },

-- CSV operations
{ "<leader>csa", desc = "align CSV" },
{ "<leader>csA", desc = "clear CSV alignment" },
{ "[c", desc = "previous CSV column" },
{ "]c", desc = "next CSV column" },
})