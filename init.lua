-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

--NOTE: this is for remove space after save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.cmd([[%s/\s\+$//e]])
  end,
})

--NOTE: Auto-enable spell checking for certain filetypes (useful for md files)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit", "latex" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "ms", "en_us" }
  end,
})


--NOTE:   if you use neovide
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h14:b" -- Replace h14 with your desired font size
  -- vim.g.neovide_window_blurred = true
  -- vim.g.neovide_opacity = 0.93
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_refresh_rate = 75
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_hide_titlebar = true
  vim.g.neovide_padding_bottom = -2
end
