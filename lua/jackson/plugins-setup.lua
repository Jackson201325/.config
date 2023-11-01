local fn = vim.fn

local ensure_packer = function()
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local packer_bootstrap = ensure_packer()

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.startup(function(use)
	use("wbthomason/packer.nvim")

	-- My plugins here
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")

	-- Color scheme
	use("folke/tokyonight.nvim")

	-- Replacing surroundings
	use("tpope/vim-surround")

	-- CMP plugins
	use("hrsh7th/nvim-cmp") -- Autocompletion plugin
	use("hrsh7th/cmp-buffer") -- Autocompletion for buffers
	use("hrsh7th/cmp-path") -- Autocompletion for paths
	use("hrsh7th/cmp-cmdline") -- Autocompletion for cmdline
	use("hrsh7th/cmp-nvim-lsp")
	use("onsails/lspkind-nvim")

	-- snippets
	use("L3MON4D3/LuaSnip") -- Snippets plugin
	use("saadparwaiz1/cmp_luasnip") -- Autocompletion for snippets
	use("rafamadriz/friendly-snippets") -- Snippets collection

	-- LSP
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")
	use("nvimtools/none-ls.nvim")
	use("folke/neodev.nvim")
	use("kchmck/vim-coffee-script")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-live-grep-args.nvim")
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})
	use("nvim-telescope/telescope-project.nvim")
	use({ "axkirillov/easypick.nvim", requires = "nvim-telescope/telescope.nvim" })

	-- Coding
	use("windwp/nvim-ts-autotag")
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("windwp/nvim-autopairs")
	use("tpope/vim-endwise")
	use("numToStr/Comment.nvim")
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({ ---@usage set to false to disable project.nvim.
				--- This is on by default since it's currently the expected behavior.
				active = true,

				on_config_done = nil,

				---@usage set to true to disable setting the current-woriking directory
				--- Manual mode doesn't automatically change your root directory, so you have
				--- the option to manually do so using `:ProjectRoot` command.
				manual_mode = false,

				---@usage Methods of detecting the root directory
				--- Allowed values: **"lsp"** uses the native neovim lsp
				--- **"pattern"** uses vim-rooter like glob pattern matching. Here
				--- order matters: if one is not detected, the other is used as fallback. You
				--- can also delete or rearangne the detection methods.
				-- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
				detection_methods = { "pattern" },

				---@usage patterns used to detect root dir, when **"pattern"** is in detection_methods
				patterns = { ".git" },

				---@ Show hidden files in telescope when searching for files in a project
				show_hidden = false,

				---@usage When set to false, you will get a message when project.nvim changes your directory.
				-- When set to false, you will get a message when project.nvim changes your directory.
				silent_chdir = true,

				---@usage list of lsp client names to ignore when using **lsp** detection. eg: { "efm", ... }
				ignore_lsp = {},

				---@type string
				---@usage path to store the project history for use in telescope
				datapath = vim.fn.stdpath("data"),
			})
		end,
	})
	use({
		"cappyzawa/trim.nvim",
		config = function()
			require("trim").setup({})
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
		requires = "nvim-treesitter/nvim-treesitter",
	})
	use({ "mg979/vim-visual-multi", branch = "master" })

	-- UI
	use("roobert/tailwindcss-colorizer-cmp.nvim")
	use("lewis6991/gitsigns.nvim")
	use("xiyaowong/transparent.nvim")
	use("goolord/alpha-nvim")
	use("NvChad/nvim-colorizer.lua")
	use("folke/which-key.nvim")
	use("RRethy/vim-illuminate")
	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
	use({ "kevinhwang91/nvim-bqf", ft = "qf" })
	-- use("luukvbaal/statuscol.nvim")
	use({
		"folke/noice.nvim",
		requires = { "MunifTanjim/nui.nvim" },
	})

	-- Movement
	use("mbbill/undotree")
	use("ThePrimeagen/harpoon")
	-- use("christoomey/vim-tmux-navigator")
	use("tpope/vim-repeat")
	use("folke/flash.nvim")

	-- Neo Tree
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	})

	-- Toggle terminal
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
	})

	-- Bufferline
	use("akinsho/bufferline.nvim")

	-- Status line
	use("nvim-lualine/lualine.nvim")

	-- Copilot
	use({
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "bottom", -- | top | left | right
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = false,
					debounce = 75,
					keymap = {
						accept = "<M-l>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = "node", -- Node.js version must be > 16.x
				server_opts_overrides = {},
			})
		end,
	})
	use({
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	})
	-- Sessions Management
	use("olimorris/persisted.nvim")

	-- Indentation line
	use("lukas-reineke/indent-blankline.nvim")
	use("echasnovski/mini.indentscope")

	-- Delete buffer but not split
	use("echasnovski/mini.bufremove")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
