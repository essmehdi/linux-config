-- Check if PowerShell executable is available
local pwsh_executable = vim.fn.executable 'pwsh' == 1
local shell = pwsh_executable and 'pwsh' or 'powershell'

-- Set shell options
vim.opt.shell = shell
vim.opt.shellcmdflag =
  "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
vim.opt.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
vim.opt.shellquote = ''
vim.opt.shellxquote = ''

vim.opt.hlsearch=false
vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.relativenumber=true
vim.opt.termguicolors=true
vim.opt.fillchars = { eob = ' ' }
vim.wo.wrap = false

vim.opt.laststatus = 3

-- Transparent BG
vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]
