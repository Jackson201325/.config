local autopairs_setup, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_setup then
  print("autopairs not ok")
  return
end

-- configure autopairs
autopairs.setup({
  check_ts = true, -- enable treesitter
  ts_config = {
    -- lua = { "string" }, -- don't add pairs in lua string treesitter nodes
    javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
    typescript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
    java = false,                     -- don't check treesitter on java
    typescriptreact = false,
  },
})

-- import nvim-autopairs completion functionality safely
local cmp_autopairs_setup, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not cmp_autopairs_setup then
  print("cmp_autopairs_setup not ok")
  return
end

-- import nvim-cmp plugin safely (completions plugin)
local cmp_setup, cmp = pcall(require, "cmp")
if not cmp_setup then
  return
end

-- make autopairs and completion work together
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
