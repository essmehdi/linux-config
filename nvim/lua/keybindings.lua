vim.g.mapleader = " "

local open_float = function()
	vim.diagnostic.open_float({
		scope = "line"
	})
end

local builtin = require("telescope.builtin")
local fff = require("fff");
vim.keymap.set('n', '<leader>ff', fff.find_files, {})
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ft', ':Neotree toggle<CR>', {})
vim.keymap.set('n', '<leader>dl', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, {})
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, {})
vim.keymap.set('n', '<leader>df', open_float, {})
vim.keymap.set('n', '<leader>cc', vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, {})
vim.keymap.set('n', '<leader>cs', vim.lsp.buf.signature_help, {})
vim.keymap.set('n', '<leader>ca', builtin.lsp_document_symbols)
vim.keymap.set('n', '<leader>co', ':OrganizeImports<CR>', {}) -- TypeScript organize imports

vim.lsp.handlers["textDocument/definition"] = builtin.lsp_definitions
vim.lsp.handlers["textDocument/references"] = builtin.lsp_references
