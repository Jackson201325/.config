local status_ok, nvim_ufo = pcall(require, "ufo")
if not status_ok then
  print("UFO scope not ok")
  return
end

-- local ftMap = {
--   vim = "indent",
--   python = { "indent" },
--   git = "",
-- }

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" 󰁂 %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

vim.keymap.set("n", "zR", nvim_ufo.openAllFolds)
vim.keymap.set("n", "zM", nvim_ufo.closeAllFolds)
vim.keymap.set("n", "zr", nvim_ufo.openFoldsExceptKinds)
vim.keymap.set("n", "zm", nvim_ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

nvim_ufo.setup({
  open_fold_hl_timeout = 150,
  close_fold_kinds = {},
  preview = {
    win_config = {
      border = { "", "─", "", "", "", "─", "", "" },
      winhighlight = "Normal:Folded",
      winblend = 0,
    },
    mappings = {
      scrollU = "<C-u>",
      scrollD = "<C-d>",
      jumpTop = "[",
      jumpBot = "]",
    },
  },
  fold_virt_text_handler = handler,
  provider_selector = function(bufnr, filetype, buftype)
    -- if you prefer treesitter provider rather than lsp,
    -- return ftMap[filetype] or {'treesitter', 'indent'}
    -- return ftMap[filetype]
    return { "lsp", "indent" }
  end,
  enable_get_fold_virt_text = true
})
