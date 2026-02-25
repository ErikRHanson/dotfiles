-- Simple init.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  "folke/tokyonight.nvim",       -- A clean, modern theme
  "neovim/nvim-lspconfig",       -- Enables Python/Rust/SQL support
  "hrsh7th/nvim-cmp",            -- Autocompletion engine
  "hrsh7th/cmp-nvim-lsp",        -- LSP source for autocompletion
  "nvim-treesitter/nvim-treesitter", -- Better syntax highlighting (DuckDB/SQL)
})

-- Settings
vim.cmd[[colorscheme tokyonight]]
vim.opt.number = true            -- Show line numbers
vim.opt.shiftwidth = 4           -- Python-friendly indents
vim.opt.expandtab = true
