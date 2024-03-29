local status_ok, tk = pcall(require, "tokyonight")
if not status_ok then
  print("Tk not ok")
  return
end

tk.setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "night",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  -- light_style = "night", -- The theme is used when the background is set to light
  transparent = true,     -- Enable this to disable setting the background color
  -- tokyonight_dark_float = false,
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = false },
    keywords = { italic = false },
    functions = { bold = true },
    variables = { bold = false },
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "transparent",       -- style for sidebars, see below
    floats = "transparent",         -- style for floating windows
  },
  sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false,             -- dims inactive windows
  lualine_bold = true,              -- When `true`, section headers in the lualine theme will be bold
  --
  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
})

local colorscheme = "tokyonight-night"

local status, _ = pcall(function()
  vim.cmd("colorscheme " .. colorscheme)
end)

if not status then
  vim.notify("colorscheme: " .. colorscheme .. " not found!")
  return
end
