local profile = require("config.profile")

-- LMStudio connection details (shared between probe and minuet endpoint)
local _lmstudio_host = "127.0.0.1"
local _lmstudio_port = 1234

-- Availability flags (nil = unknown/pending, true = up, false = down)
local _copilot_available = nil
local _lmstudio_available = nil

if profile.full then
	require("mason").setup({
		pip = {
			upgrade_pip = true,
			install_args = { "--no-cache-dir" },
		},
	})
	require("mason-lspconfig").setup()

	-- Async check: can we reach copilot?
	vim.uv.getaddrinfo("copilot-proxy.githubusercontent.com", nil, nil, function(err, res)
		_copilot_available = err == nil and res ~= nil and #res > 0
	end)

	-- Async TCP probe: is LMStudio actually listening?
	local _tcp = vim.uv.new_tcp()
	_tcp:connect(_lmstudio_host, _lmstudio_port, function(err)
		_lmstudio_available = err == nil
		_tcp:close()
	end)

	require("copilot").setup({
		suggestion = { enabled = false },
		panel = { enabled = false },
		server_opts_overrides = {
			settings = {
				advanced = { listCount = 10 },
			},
		},
	})
end

-- Build providers table: ripgrep always, copilot/minuet in full only
local providers = {
	ripgrep = {
		module = "blink-ripgrep",
		name = "Ripgrep",
		opts = { prefix_min_len = 3 },
	},
}

local default_sources
if profile.full then
	providers.copilot = {
		name = "copilot",
		module = "blink-copilot",
		async = true,
		score_offset = 100,
	}
	providers.minuet = {
		name = "minuet",
		module = "minuet.blink",
		async = true,
		score_offset = 50,
		timeout_ms = 15000,
	}
	default_sources = function()
		local srcs = { "lsp", "path", "snippets", "buffer", "cmdline", "ripgrep" }
		-- copilot_available is nil (unknown) or true → use copilot; false → fall back to minuet
		if _copilot_available == false then
			if _lmstudio_available ~= false then
				table.insert(srcs, "minuet")
			end
		else
			table.insert(srcs, "copilot")
		end
		return srcs
	end
else
	default_sources = { "buffer", "path", "snippets", "cmdline", "ripgrep" }
end

require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },
		["<C-y>"] = { "select_and_accept" },
		["<CR>"] = { "accept", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },
		["<C-u>"] = { "scroll_documentation_up", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
	},
	appearance = { nerd_font_variant = "mono" },
	completion = {
		menu = {
			border = "rounded",
			draw = {
				components = {
					kind_icon = {
						text = function(ctx)
							if ctx.source_name == "minuet" then
								return "󰚩"
							end
							return ctx.kind_icon .. ctx.icon_gap
						end,
					},
				},
			},
		},
		documentation = {
			auto_show = true,
			window = { border = "rounded" },
		},
	},
	sources = {
		default = default_sources,
		providers = providers,
	},
})

if profile.full then
	require("minuet").setup({
		provider = "openai_compatible",
		n_completions = 1,
		context_window = 16384,
		request_timeout = 15,
		provider_options = {
			openai_compatible = {
				end_point = "http://" .. _lmstudio_host .. ":" .. _lmstudio_port .. "/v1/chat/completions",
				stream = true,
				name = "LMStudio",
				api_key = "TERM",
				model = "mistralai/devstral-small-2-2512",
				optional = {
					temperature = 0.15,
					max_tokens = 256,
				},
			},
		},
	})

	require("lazydev").setup({
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	})

	vim.lsp.config("*", {
		capabilities = require("blink.cmp").get_lsp_capabilities(),
		on_attach = function(client, bufnr)
			local opts = { buffer = bufnr, silent = true }
			vim.keymap.set("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
			vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gh", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
			vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
			vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<leader>ll", vim.lsp.codelens.run, opts)
			vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, opts)
			if client and client.supports_method("textDocument/inlayHint") then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end,
	})

	vim.lsp.config("gopls", {
		cmd = { "gopls" },
		root_markers = { "go.work", "go.mod", ".git" },
		settings = {
			gopls = {
				gofumpt = true,
				analyses = { unusedparams = true, shadow = true },
				staticcheck = true,
				completeUnimported = true,
				usePlaceholders = true,
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
				},
			},
		},
	})

	vim.lsp.config("golangci_lint_ls", {
		cmd = { "golangci-lint-langserver" },
		root_markers = { ".golangci.yml", ".golangci.yaml", "go.mod" },
	})

	vim.lsp.enable("gopls")
	vim.lsp.enable("golangci_lint_ls")
end
