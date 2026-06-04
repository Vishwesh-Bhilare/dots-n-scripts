local M = {}

function M.apply()
    local bg = vim.fn.system(
        "grep '^background=' ~/.cache/wal/colors.sh | cut -d\\' -f2"
    ):gsub("\n", "")

    local fg = vim.fn.system(
        "grep '^foreground=' ~/.cache/wal/colors.sh | cut -d\\' -f2"
    ):gsub("\n", "")

    vim.api.nvim_set_hl(0, "NormalFloat", {
        bg = bg,
    })

    vim.api.nvim_set_hl(0, "FloatBorder", {
        bg = bg,
        fg = fg,
    })
end

return M
