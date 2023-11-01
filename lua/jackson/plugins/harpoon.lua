local status_ok, mark = pcall(require, "harpoon.mark")
if not status_ok then
  return
end

local harpoon_status_ok, ui = pcall(require, "harpoon.ui")
if not harpoon_status_ok then
  return
end

vim.keymap.set("n", "<C-g>", mark.add_file, { desc = "Add file to harpoon" })
vim.keymap.set("n", "<C-f>", ui.toggle_quick_menu, { desc = "Toggle harpoon menu" })

vim.keymap.set("n", "<C-e>", function()
  ui.nav_next()
end, { desc = "Navigate to next harpoon mark" })

vim.keymap.set("n", "<C-w>", function()
  ui.nav_prev()
end, { desc = "Navigate to previous harpoon mark" })
