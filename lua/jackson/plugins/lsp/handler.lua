local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local signs = {

		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "ga", "<cmd>Lspsaga code_action<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	keymap(bufnr, "n", "gc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>Lspsaga goto_definition zz<CR>", opts)
	keymap(bufnr, "n", "gD", ":vsplit | Lspsaga goto_definition<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)
	keymap(bufnr, "n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	keymap(bufnr, "n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "References" })
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
		vim.keymap.set(
			"n",
			"ta",
			"<cmd>TypescriptAddMissingImports<CR>",
			{ buffer = bufnr, desc = "Add missing imports" }
		)
		vim.keymap.set("n", "tr", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = bufnr })
		vim.keymap.set("n", "tf", "<cmd>TypescriptFixAll<CR>", { desc = "Fix File", buffer = bufnr })
		vim.keymap.set("n", "td", "<cmd>TypescriptGoToSourceDefinition<CR>", { desc = "Go to Definition" })
		vim.keymap.set("n", "to", "<cmd>TypescriptOrganizeImports<CR>", { desc = "Rename File", buffer = bufnr })
		vim.keymap.set("n", "tu", "<cmd>TypescriptRemoveUnsed<CR>", { desc = "Rename File", buffer = bufnr })
	end

	if client.name == "solargraph" then
		client.server_capabilities.documentFormattingProvider = false
	end

	lsp_keymaps(bufnr)

	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end

	illuminate.on_attach(client)

	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format()
			end,
		})
	end

	-- Autoformat
	-- vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = true})]])
end

return M
