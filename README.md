# theme-switcher.nvim

A Neovim plugin for seamless colorscheme switching with persistence and live preview using Telescope.

## Features

- 🎨 Interactive colorscheme picker with live preview
- 💾 Automatic persistence of selected colorscheme
- ⌨️ Configurable keymap (default: `<leader>cs`)
- 🔧 Fully customizable options
- 📋 User commands for manual control

## Requirements

- Neovim >= 0.7.0
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'dangho1/theme-switcher.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("theme-switcher").setup()
  end,
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'dangho1/theme-switcher.nvim",
  requires = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("theme-switcher").setup()
  end,
}
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'nvim-telescope/telescope.nvim'
Plug 'dangho1/theme-switcher.nvim'
```

Then add to your `init.lua`:
```lua
require("theme-switcher").setup()
```

## Configuration

### Default Configuration

```lua
require("theme-switcher").setup({
  keymap = "<leader>cs",
  save_path = vim.fn.stdpath("config") .. "/lua/default-colorscheme.lua",
  telescope_opts = {
    enable_preview = true,
  },
  notify = true,
})
```

### Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `keymap` | `string` or `false` | `"<leader>cs"` | Keymap to open colorscheme picker. Set to `false` to disable. |
| `save_path` | `string` | `~/.config/nvim/lua/default-colorscheme.lua` | Path where the default colorscheme is saved |
| `telescope_opts` | `table` | `{ enable_preview = true }` | Options passed to telescope colorscheme picker |
| `notify` | `boolean` | `true` | Whether to show notifications when colorscheme is changed |

### Custom Configuration Example

```lua
require("theme-switcher").setup({
  keymap = "<leader>tc", -- Custom keymap
  save_path = vim.fn.stdpath("data") .. "/theme.lua", -- Save to data directory
  telescope_opts = {
    enable_preview = true,
    layout_config = {
      width = 0.8,
      height = 0.8,
    },
  },
  notify = false, -- Disable notifications
})
```

## Usage

### Interactive Picker
- Press `<leader>cs` (or your custom keymap) to open the colorscheme picker
- Use arrow keys or `j/k` to navigate
- See live preview as you navigate
- Press `Enter` to select and save the colorscheme

### Commands
- `:ThemePick` - Open the colorscheme picker
- `:ThemeSave` - Save the current colorscheme as default

### Programmatic API

```lua
local theme_switcher = require("theme-switcher")

-- Open colorscheme picker
theme_switcher.pick()

-- Save current colorscheme
theme_switcher.save_current()

-- Get current configuration
local config = theme_switcher.get_config()
```

## How It Works

1. **Persistence**: When you select a colorscheme, it's saved to a lua file (default: `default-colorscheme.lua`)
2. **Restoration**: On startup, load the saved colorscheme from the persistence file
3. **Live Preview**: Uses Telescope's preview feature to show colorscheme changes in real-time

### Setting Up Automatic Loading

To automatically load your saved colorscheme on startup, add this to your `init.lua`:

```lua
-- Load saved colorscheme
local ok, colorscheme = pcall(require, "default-colorscheme")
if ok then
  vim.cmd.colorscheme(colorscheme)
end
```

## Troubleshooting

### Telescope not found
Make sure telescope.nvim is installed and loaded before theme-switcher.nvim.

### Colorscheme not persisting
Check that the `save_path` directory exists and is writable.

### No colorschemes showing
Ensure you have colorscheme plugins installed and loaded.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

MIT License
