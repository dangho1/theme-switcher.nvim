if vim.g.loaded_theme_switcher then
  return
end
vim.g.loaded_theme_switcher = true

vim.api.nvim_create_user_command("ThemePick", function()
  require("theme-switcher").pick()
end, { desc = "Open colorscheme picker" })

vim.api.nvim_create_user_command("ThemeSave", function()
  require("theme-switcher").save_current()
end, { desc = "Save current colorscheme as default" })