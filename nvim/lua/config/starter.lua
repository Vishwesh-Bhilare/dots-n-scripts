require("mini.starter").setup({
  evaluate_single = true,
  header = table.concat({
    "╔════════════════════════════╗",
    "║        🧠 NVim Vishy       ║",
    "╚════════════════════════════╝",
    "",
  }, "\n"),
  items = {
    { name = "📝 New file",       action = "enew",                   section = "Files" },
    { name = "🔍 Find file",      action = "Telescope find_files",   section = "Files" },
    { name = "📂 File browser",   action = "NvimTreeToggle",         section = "Files" },
    { name = "🕑 Recent files",   action = "Telescope oldfiles",     section = "Recent" },
    { name = "🔎 Live grep",      action = "Telescope live_grep",    section = "Search" },
    { name = "📖 Help",           action = "Telescope help_tags",    section = "Search" },
    { name = "⚙️  Edit config",   action = "edit ~/.config/nvim/init.lua", section = "Config" },
    { name = "❌ Quit",           action = "qa",                     section = "Session" },
  },
  footer = "🚀 Ready to code! - LazyVim IDE Setup",
})
