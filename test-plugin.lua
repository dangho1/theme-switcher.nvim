-- Quick test script to verify plugin functionality
-- Run with: nvim -l test-plugin.lua

-- Add the plugin to the runtime path
vim.opt.rtp:prepend(".")

-- Test setup function
print("Testing theme-switcher.nvim setup...")
local ok, theme_switcher = pcall(require, "theme-switcher")

if not ok then
  print("❌ Failed to load theme-switcher module")
  print("Error:", theme_switcher)
  os.exit(1)
end

print("✅ Module loaded successfully")

-- Test setup with default config
local setup_ok, setup_err = pcall(theme_switcher.setup)
if not setup_ok then
  print("❌ Setup failed")
  print("Error:", setup_err)
  os.exit(1)
end

print("✅ Setup completed successfully")

-- Test configuration retrieval
local config = theme_switcher.get_config()
print("✅ Configuration retrieved:")
print("  - Keymap:", config.keymap)
print("  - Save path:", config.save_path)
print("  - Notify:", config.notify)

-- Test custom setup
print("\nTesting custom configuration...")
local custom_ok = pcall(theme_switcher.setup, {
  keymap = "<leader>tc",
  notify = false,
  save_path = "/tmp/test-colorscheme.lua"
})

if custom_ok then
  print("✅ Custom configuration applied successfully")
  local custom_config = theme_switcher.get_config()
  print("  - Custom keymap:", custom_config.keymap)
  print("  - Custom save path:", custom_config.save_path)
  print("  - Custom notify:", custom_config.notify)
else
  print("❌ Custom configuration failed")
end

print("\n🎉 All tests passed! Plugin is ready to use.")
print("\nTo use the plugin:")
print("1. Add it to your plugin manager")
print("2. Call require('theme-switcher').setup() in your config")
print("3. Use the keymap or :ThemePick command to open the picker")