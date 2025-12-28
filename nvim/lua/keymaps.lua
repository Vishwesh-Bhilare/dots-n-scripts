-- Telescope
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')

-- File tree
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')

-- Run current file (Space + r)
vim.keymap.set('n', '<leader>r', function()
vim.cmd("w") -- save before running

local ft = vim.bo.filetype
local file = vim.fn.shellescape(vim.fn.expand("%:p"))
local cmd = ""

if ft == "javascript" then
  cmd = "node " .. file

  elseif ft == "python" then
    cmd = "python " .. file

    elseif ft == "cpp" or ft == "c" then
      local output = vim.fn.shellescape(vim.fn.expand("%:p:r"))
      local compiler = (ft == "cpp") and "g++" or "gcc"
      cmd = string.format("%s %s -o %s && %s", compiler, file, output, output)

      else
        print("Unsupported filetype: " .. ft)
        return
        end

        vim.cmd("split | terminal " .. cmd)
        end, { noremap = true, silent = true })

-- Quit
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<leader>q', '<C-\\><C-n>:q<CR>', { noremap = true, silent = true })
