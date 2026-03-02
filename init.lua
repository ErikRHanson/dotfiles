-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  { import = "lazyvim.plugins.extras.lang.python" }, -- Everything for your Python/DuckDB work
  { import = "lazyvim.plugins.extras.lang.sql" },    -- For DuckDB/SQL queries
  { "folke/tokyonight.nvim", opts = { style = "storm" } },
})