require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

local fff = require "fff"

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>ff", function()
  fff.find_files()
end, { desc = "Find files using FFF" })
-- map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
