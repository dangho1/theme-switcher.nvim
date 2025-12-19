local M = {}

local config = {
  keymap = "<leader>cs",
  save_path = vim.fn.stdpath("config") .. "/lua/default-colorscheme.lua",
  telescope_opts = {
    enable_preview = true,
  },
  notify = true,
}

local function save_colorscheme(colorscheme)
  local file = io.open(config.save_path, "w")
  if file then
    file:write('return "' .. colorscheme .. '"')
    file:close()
    if config.notify then
      vim.notify("Default colorscheme set to " .. colorscheme)
    end
  else
    vim.notify("Failed to save colorscheme to " .. config.save_path, vim.log.levels.ERROR)
  end
end

local function open_colorscheme_picker()
  local telescope_ok, telescope_builtin = pcall(require, "telescope.builtin")
  if not telescope_ok then
    vim.notify("Telescope is required for theme-switcher.nvim", vim.log.levels.ERROR)
    return
  end

  local actions_ok, actions = pcall(require, "telescope.actions")
  local actions_state_ok, actions_state = pcall(require, "telescope.actions.state")
  
  if not actions_ok or not actions_state_ok then
    vim.notify("Telescope actions are required for theme-switcher.nvim", vim.log.levels.ERROR)
    return
  end

  local opts = vim.tbl_deep_extend("force", config.telescope_opts, {
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        local selection = actions_state.get_selected_entry()
        actions.close(prompt_bufnr)
        
        vim.cmd.colorscheme(selection.value)
        save_colorscheme(selection.value)
      end)
      return true
    end,
  })

  telescope_builtin.colorscheme(opts)
end

function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})
  
  if config.keymap then
    vim.keymap.set("n", config.keymap, open_colorscheme_picker, { 
      desc = "Open colorscheme picker",
      silent = true 
    })
  end
end

function M.pick()
  open_colorscheme_picker()
end

function M.save_current()
  local current = vim.g.colors_name
  if current then
    save_colorscheme(current)
  else
    vim.notify("No colorscheme is currently active", vim.log.levels.WARN)
  end
end

function M.get_config()
  return config
end

return M