require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "rust_analyzer", "tombi", "qmlls", "hyprls", "dockerls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
