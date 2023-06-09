local opt = vim.opt

-- line numbers
opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers

-- tabs & indentation
opt.list = true -- Show some invisible characters (tabs...
opt.tabstop = 2 -- Number of spaces tabs count for
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.smartindent = true -- Insert indents automatically
opt.expandtab = true

-- line wrapping
opt.wrap = false -- Disable line wrap

-- search settings
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals

-- cursor line
opt.cursorline = true -- Enable highlighting of the current line

-- appeareance
opt.termguicolors = true -- True color support
opt.background = "dark"

-- backspace
opt.backspace = "indent,eol,start"

opt.cmdheight = 0 -- More space for displaying messages
opt.autowrite = true
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.formatoptions = "joqlnt" -- tcq
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.scrolloff = 8 -- Lines of context
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
opt.mouse = "a" -- Enable muse mode
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.showmode = false -- Dont show mode since we have a statusline
opt.shortmess:append({ W = true, I = true, c = true })
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 10 -- Minimum window width
opt.winbar = "%=%m %f"

-- if vim.fn.has("nvim-0.9.0") == 1 then
-- 	opt.splitkeep = "screen"
-- 	opt.shortmess:append({ W = true, I = true, c = true })
-- end

-- Fix markdown indentation settings
-- vim.g.markdown_recommended_style = 0

-- vim.o.foldcolumn = "1" -- '0' is not bad
-- vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
-- vim.o.foldlevelstart = 99
-- vim.o.foldenable = true

-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.fen = false
