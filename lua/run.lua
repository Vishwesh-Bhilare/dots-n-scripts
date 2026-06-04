local M = {}

-- Function to run files in floating window
M.run_file = function()
    local filetype = vim.bo.filetype
    local filename = vim.fn.expand("%:p")
    local filename_no_ext = vim.fn.expand("%:r")
    
    -- Save first
    vim.cmd("w")
    
    -- Create a unique buffer for terminal
    local buf = vim.api.nvim_create_buf(false, true)
    local width = vim.api.nvim_get_option("columns")
    local height = vim.api.nvim_get_option("lines")
    
    local win_height = math.ceil(height * 0.6)
    local win_width = math.ceil(width * 0.8)
    local row = math.ceil((height - win_height) / 2)
    local col = math.ceil((width - win_width) / 2)
    
    local opts = {
        style = "minimal",
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col,
        border = "single"
    }
    
    local win = vim.api.nvim_open_win(buf, true, opts)

    vim.wo[win].winhighlight =
		"NormalFloat:NormalFloat,FloatBorder:FloatBorder"
    
    -- Set terminal in the buffer
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':close<CR>', {noremap = true, silent = true})
    
    local cmd
    if filetype == "python" then
        cmd = "python " .. vim.fn.shellescape(filename) .. "\n"
    elseif filetype == "javascript" then
        cmd = "node " .. vim.fn.shellescape(filename) .. "\n"
    elseif filetype == "typescript" then
        cmd = "npx ts-node " .. vim.fn.shellescape(filename) .. "\n"
    elseif filetype == "lua" then
        cmd = "lua " .. vim.fn.shellescape(filename) .. "\n"
    elseif filetype == "sh" or filetype == "bash" then
        cmd = "bash " .. vim.fn.shellescape(filename) .. "\n"
    elseif filetype == "c" then
        cmd = "gcc -o " .. vim.fn.shellescape(filename_no_ext) .. "_out " .. vim.fn.shellescape(filename) .. " && ./" .. vim.fn.shellescape(filename_no_ext) .. "_out\n"
    elseif filetype == "cpp" then
        cmd = "g++ -std=c++17 -o " .. vim.fn.shellescape(filename_no_ext) .. "_out " .. vim.fn.shellescape(filename) .. " && ./" .. vim.fn.shellescape(filename_no_ext) .. "_out\n"
    elseif filetype == "java" then
        local classname = vim.fn.expand("%:t:r")
        cmd = "javac " .. vim.fn.shellescape(filename) .. " && java " .. classname .. "\n"
    elseif filetype == "rust" then
        cmd = "cargo run\n"
    elseif filetype == "go" then
        cmd = "go run " .. vim.fn.shellescape(filename) .. "\n"
    else
        vim.api.nvim_win_close(win, true)
        print("Unsupported filetype: " .. filetype)
        return
    end
    
    -- Send command to terminal
    vim.fn.termopen(cmd)
    vim.cmd("startinsert")
end

-- Original function for running in split terminal (keep for compatibility)
M.run_in_terminal = function()
    local filetype = vim.bo.filetype
    local filename = vim.fn.expand("%:p")
    local filename_no_ext = vim.fn.expand("%:r")
    
    if filetype == "python" then
        vim.cmd("w")
        vim.cmd("term python " .. vim.fn.shellescape(filename))
    elseif filetype == "javascript" then
        vim.cmd("w")
        vim.cmd("term node " .. vim.fn.shellescape(filename))
    elseif filetype == "typescript" then
        vim.cmd("w")
        vim.cmd("term npx ts-node " .. vim.fn.shellescape(filename))
    elseif filetype == "lua" then
        vim.cmd("w")
        vim.cmd("term lua " .. vim.fn.shellescape(filename))
    elseif filetype == "sh" or filetype == "bash" then
        vim.cmd("w")
        vim.cmd("term bash " .. vim.fn.shellescape(filename))
    elseif filetype == "c" then
        vim.cmd("w")
        local compile_cmd = "gcc -o " .. vim.fn.shellescape(filename_no_ext) .. "_out " .. vim.fn.shellescape(filename) .. " && ./" .. vim.fn.shellescape(filename_no_ext) .. "_out"
        vim.cmd("term " .. compile_cmd)
    elseif filetype == "cpp" then
        vim.cmd("w")
        local compile_cmd = "g++ -std=c++17 -o " .. vim.fn.shellescape(filename_no_ext) .. "_out " .. vim.fn.shellescape(filename) .. " && ./" .. vim.fn.shellescape(filename_no_ext) .. "_out"
        vim.cmd("term " .. compile_cmd)
    elseif filetype == "java" then
        vim.cmd("w")
        local classname = vim.fn.expand("%:t:r")
        local compile_cmd = "javac " .. vim.fn.shellescape(filename) .. " && java " .. classname
        vim.cmd("term " .. compile_cmd)
    elseif filetype == "rust" then
        vim.cmd("w")
        vim.cmd("term cargo run")
    elseif filetype == "go" then
        vim.cmd("w")
        vim.cmd("term go run " .. vim.fn.shellescape(filename))
    else
        print("Unsupported filetype for running: " .. filetype)
    end
end

-- Function to debug files (if needed)
M.debug_file = function()
    local filetype = vim.bo.filetype
    local filename = vim.fn.expand("%:p")
    
    if filetype == "python" then
        vim.cmd("w")
        vim.cmd("term python -m pdb " .. vim.fn.shellescape(filename))
    elseif filetype == "c" or filetype == "cpp" then
        vim.cmd("w")
        local filename_no_ext = vim.fn.expand("%:r")
        local compile_cmd
        if filetype == "c" then
            compile_cmd = "gcc -g -o " .. vim.fn.shellescape(filename_no_ext) .. "_debug " .. vim.fn.shellescape(filename) .. " && gdb " .. vim.fn.shellescape(filename_no_ext) .. "_debug"
        else
            compile_cmd = "g++ -std=c++17 -g -o " .. vim.fn.shellescape(filename_no_ext) .. "_debug " .. vim.fn.shellescape(filename) .. " && gdb " .. vim.fn.shellescape(filename_no_ext) .. "_debug"
        end
        vim.cmd("term " .. compile_cmd)
    else
        print("Debug not supported for: " .. filetype)
    end
end

-- Function to run in floating terminal (if FTerm is installed)
M.run_in_floating_term = function()
    local filetype = vim.bo.filetype
    local filename = vim.fn.expand("%:p")
    local filename_no_ext = vim.fn.expand("%:r")
    
    local command
    
    if filetype == "python" then
        command = "python " .. filename .. "; echo 'Press Enter to close...'; read"
    elseif filetype == "javascript" then
        command = "node " .. filename .. "; echo 'Press Enter to close...'; read"
    elseif filetype == "typescript" then
        command = "npx ts-node " .. filename .. "; echo 'Press Enter to close...'; read"
    elseif filetype == "lua" then
        command = "lua " .. filename .. "; echo 'Press Enter to close...'; read"
    elseif filetype == "sh" or filetype == "bash" then
        command = "bash " .. filename .. "; echo 'Press Enter to close...'; read"
    elseif filetype == "c" then
        command = "gcc -o " .. filename_no_ext .. "_out " .. filename .. " && ./" .. filename_no_ext .. "_out; echo 'Press Enter to close...'; read"
    elseif filetype == "cpp" then
        command = "g++ -std=c++17 -o " .. filename_no_ext .. "_out " .. filename .. " && ./" .. filename_no_ext .. "_out; echo 'Press Enter to close...'; read"
    elseif filetype == "java" then
        local classname = vim.fn.expand("%:t:r")
        command = "javac " .. filename .. " && java " .. classname .. "; echo 'Press Enter to close...'; read"
    elseif filetype == "rust" then
        command = "cargo run; echo 'Press Enter to close...'; read"
    elseif filetype == "go" then
        command = "go run " .. filename .. "; echo 'Press Enter to close...'; read"
    else
        print("Unsupported filetype: " .. filetype)
        return
    end
    
    vim.cmd("w")
    
    -- If FTerm is installed, use it
    local fterm_ok, fterm = pcall(require, "FTerm")
    if fterm_ok then
        local runner = fterm:new({
            ft = 'fterm_' .. filetype,
            cmd = command,
            dimensions = {
                height = 0.6,
                width = 0.8,
            }
        })
        runner:toggle()
    else
        -- Fallback to regular terminal
        vim.cmd("term " .. command)
    end
end

return M
