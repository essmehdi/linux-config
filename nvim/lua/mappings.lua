require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

local fff = require "fff"
local builtin = require("telescope.builtin")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "grr", builtin.lsp_references, { desc = "LSP References" })
map("n", "gri", builtin.lsp_implementations, { desc = "LSP Implementations" })
map("n", "grt", builtin.lsp_type_definitions, { desc = "LSP Type definitions" })
map("n", "<leader>ff", function()
  fff.find_files()
end, { desc = "Find files using FFF" })
-- map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
