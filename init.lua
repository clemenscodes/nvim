require("catppuccin").setup({
  ["background"] = { ["dark"] = "macchiato", ["light"] = "macchiato" },
  ["dim_inactive"] = { ["enabled"] = true },
  ["flavour"] = "macchiato",
  ["integrations"] = { ["alpha"] = true, ["cmp"] = true, ["dap"] = { ["enable_ui"] = true, ["enabled"] = true }, ["gitsigns"] = true, ["illuminate"] = { ["enabled"] = true, ["lsp"] = true }, ["native_lsp"] = { ["enabled"] = true, ["inlay_hints"] = { ["background"] = true } }, ["notify"] = true, ["nvimtree"] = true, ["rainbow_delimiters"] = true, ["telescope"] = { ["enabled"] = true }, ["treesitter"] = true, ["which_key"] = true }
})

vim.cmd([[
  let $BAT_THEME = 'catppuccin'
  colorscheme catppuccin
]])

-- Set up globals {{{
do
  local nixvim_globals = {
    ["loaded_node_provider"] = 0,
    ["loaded_perl_provider"] = 0,
    ["loaded_python3_provider"] = 0,
    ["loaded_ruby_provider"] = 0,
    ["mapleader"] = " ",
    ["skip_ts_context_commentstring_module"] = true,
    ["tagbar_type_rust"] = { ["ctagsbin"] = "/nix/store/nr75cki5a199d4sbfhvjzq0mi7pl1rkd-universal-ctags-6.1.0/bin/ctags", ["ctagstype"] = "rust", ["kind2scope"] = { ["M"] = "macro", ["P"] = "method", ["c"] = "implementation", ["e"] = "enumerator", ["f"] = "function", ["g"] = "enum", ["i"] = "interface", ["m"] = "field", ["n"] = "module", ["s"] = "struct", ["t"] = "typedef", ["v"] = "variable" }, ["kinds"] = { "n:modules", "s:structures:1", "i:interfaces", "c:implementations", "f:functions:1", "g:enumerations:1", "t:type aliases:1:0", "C:constants:1:0", "M:macros:1", "m:fields:1:0", "e:enum variants:1:0", "P:methods:1" }, ["sro"] = "::" }
  }

  for k, v in pairs(nixvim_globals) do
    vim.g[k] = v
  end
end
-- }}}


-- Set up options {{{
do
  local nixvim_options = {
    ["clipboard"] = "unnamedplus",
    ["cmdheight"] = 0,
    ["completeopt"] = "menu,menuone,noselect",
    ["expandtab"] = true,
    ["hlsearch"] = true,
    ["ignorecase"] = true,
    ["number"] = true,
    ["scrolloff"] = 8,
    ["shiftwidth"] = 2,
    ["signcolumn"] = "yes",
    ["smartcase"] = true,
    ["tabstop"] = 2,
    ["termguicolors"] = true,
    ["timeout"] = true,
    ["timeoutlen"] = 300,
    ["undodir"] = "~/.local/share/nvim/undo",
    ["undofile"] = true,
    ["updatetime"] = 200,
    ["virtualedit"] = "block",
    ["wrap"] = false
  }

  for k, v in pairs(nixvim_options) do
    vim.opt[k] = v
  end
end
-- }}}


vim.loader.disable()


require('neodev').setup({
  library = {
    enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
    -- these settings will be used for your Neovim config directory
    runtime = true, -- runtime path
    types = true,   -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim", "neotest" },
  },
  setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
  -- for your Neovim config directory, the config.library settings will be used as is
  -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
  -- for any other directory, config.library.enabled will be set to false
  override = function(root_dir, options) end,
  -- With lspconfig, Neodev will automatically setup your lua-language-server
  -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
  -- in your lsp start options
  lspconfig = true,
  -- much faster, but needs a recent built of lua-language-server
  -- needs lua-language-server >= 3.6.0
  pathStrict = true,
})

require('crates').setup({})

require("which-key").setup({ ["ignore_missing"] = true })
require("which-key").register({
  ["/"] = "Search incrementally",
  ["<S-Tab>"] = "Previous buffer",
  ["<Tab>"] = "Next buffer",
  ["<leader>a"] = "Rust Action",
  ["<leader>d"] = { ["b"] = "Toggle breakpoint", ["c"] = "Continue", ["k"] = "Kill debugging session", ["name"] = "+Debug" },
  ["<leader>ds"] = { ["i"] = "Step into function call", ["name"] = "+Steps", ["o"] = "Step over function call", ["u"] = "Step out of function call" },
  ["<leader>e"] = "Toggle nvim-tree",
  ["<leader>f"] = { ["f"] = "Find files", ["g"] = "Live grep", ["n"] = "Nix", ["name"] = "Telescope", ["p"] = "Projects" },
  ["<leader>fr"] = { ["a"] = "Run last rust test", ["d"] = "Find rust debuggables", ["name"] = "+Rust", ["r"] = "Find rust runnables", ["t"] = "Find rust testables" },
  ["<leader>h"] = "Clear highlights and search term",
  ["<leader>i"] = "Format",
  ["<leader>l"] = "Trigger linting for current file",
  ["<leader>nx"] = { ["a"] = "Nx actions", ["f"] = "Nx affected", ["g"] = "Nx generators", ["m"] = "Nx run-many", ["name"] = "+Nx" },
  ["<leader>o"] = "Close all buffers except current",
  ["<leader>q"] = "Close current buffer",
  ["<leader>r"] = { ["a"] = "Run all tests", ["d"] = "Debug nearest test", ["n"] = "Jump to next test", ["name"] = "+Test", ["p"] = "Jump to previous test", ["r"] = "Run nearest test" },
  ["<leader>s"] = "Search and replace",
  ["<leader>t"] = { ["name"] = "+Toggle" },
  ["<leader>tb"] = "Toggle tagbar",
  ["<leader>td"] = "Toggle dapui",
  ["<leader>th"] = "Toggle Cabal REPL",
  ["<leader>tm"] = "Toggle terminal",
  ["<leader>to"] = "Toggle test output panel",
  ["<leader>ts"] = "Toggle test summary",
  ["<leader>tt"] = "Toggle trouble",
  ["<leader>w"] = "Wipe current buffer",
  ["c"] = { ["a"] = "Select code action", ["name"] = "+LSP" }
})

require("toggleterm").setup({ ["close_on_exit"] = false, ["direction"] = "float" })

require('project_nvim').setup({ ["detection_methods"] = { "pattern" }, ["ignore_lsp"] = { "rust-analyzer" }, ["patterns"] = { ".git", "nx.json" } })

require("colorizer").setup({
  filetypes = nil,
  user_default_options = { ["names"] = false },
  buftypes = nil,
})

require('nvim-autopairs').setup({ ["check_ts"] = true })

vim.notify = require('notify');
require('notify').setup({ ["max_width"] = 200, ["render"] = "minimal", ["timeout"] = 3000, ["top_down"] = false })

local __ignored_variables = {}
for ignoredVariable, shouldIgnore in ipairs(__ignored_variables) do
  require("nix-develop").ignored_variables[ignoredVariable] = shouldIgnore
end

local __separated_variables = {}
for variable, separator in ipairs(__separated_variables) do
  require("nix-develop").separated_variables[variable] = separator
end


require('leap').add_default_mappings()
require('leap').opts = vim.tbl_deep_extend("keep", {}, require('leap').opts)

require("ibl").setup({ ["enabled"] = true })

require('nvim-cursorline').setup({ ["cursorline"] = { ["timeout"] = 0 }, ["cursorword"] = { ["enable"] = false, ["hl"] = { ["underline"] = false } } })

require("Comment").setup { ["pre_hook"] = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
, ["sticky"] = true }
require('better_escape').setup({ ["mapping"] = { "jj", "jk" } })

require('auto-save').setup({ ["write_all_buffers"] = true })

require('alpha').setup({
  ["layout"] = { { ["type"] = "padding", ["val"] = 2 }, {
    ["opts"] = { ["hl"] = "Type", ["position"] = "center" },
    ["type"] = "text",
    ["val"] = {
      "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗",
      "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║",
      "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║",
      "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║",
      "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║",
      "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝" }
  }, { ["type"] = "padding", ["val"] = 2 }, {
    ["opts"] = { ["position"] = "center" },
    ["type"] = "group",
    ["val"] = { {
      ["on_press"] = function()
        vim.cmd [[
          Telescope projects
        ]]
      end
      ,
      ["opts"] = { ["align_shortcut"] = "right", ["cursor"] = 0, ["hl"] = "hl_group", ["hl_shortcut"] = "hl_group", ["position"] = "center", ["shortcut"] = "<leader>fp", ["shrink_margin"] = true, ["width"] = 50 },
      ["type"] = "button",
      ["val"] = "  Find Projects"
    } }
  }, { ["type"] = "padding", ["val"] = 2 }, { ["opts"] = { ["hl"] = "Keyword", ["position"] = "center" }, ["type"] = "text", ["val"] = "Why use C?" } }
})

do
  local __telescopeExtensions = { "projects", "fzf" }

  require('telescope').setup({ ["extensions"] = { ["fzf"] = { ["case_mode"] = "smart_case", ["fuzzy"] = true } } })

  for i, extension in ipairs(__telescopeExtensions) do
    require('telescope').load_extension(extension)
  end
end

require("lualine").setup({ ["options"] = { ["globalstatus"] = true, ["icons_enabled"] = true } })
require("luasnip").config.set_config({})

require("luasnip.loaders.from_vscode").lazy_load({})

require("dap").adapters = { ["codelldb"] = { ["executable"] = { ["args"] = { "--port", "13000" }, ["command"] = "/nix/store/haxwgj4g2ldn8kchx0rn3iji644m3141-vscode-lldb-adapter-1.10.0/bin/codelldb" }, ["host"] = "127.0.0.1", ["port"] = 13000, ["type"] = "server" } }
require("dap").configurations = {}
require("nvim-dap-virtual-text").setup({});

require("dapui").setup({ ["controls"] = { ["element"] = "console" }, ["layouts"] = { { ["elements"] = { { ["id"] = "scopes", ["size"] = 1 } }, ["position"] = "right", ["size"] = 100 }, { ["elements"] = { { ["id"] = "repl", ["size"] = 0.500000 }, { ["id"] = "console", ["size"] = 0.500000 } }, ["position"] = "bottom", ["size"] = 15 } } });

require('trouble').setup({})

require('lspsaga').setup({ ["lightbulb"] = { ["sign"] = false } })

require("conform").setup({ ["formatters_by_ft"] = { ["css"] = { "prettierd" }, ["graphql"] = { "prettierd" }, ["html"] = { "prettierd" }, ["javascript"] = { "prettierd" }, ["javascriptreact"] = { "prettierd" }, ["json"] = { "prettierd" }, ["markdown"] = { "prettierd" }, ["nix"] = { "alejandra" }, ["rust"] = { "rustfmt" }, ["typescript"] = { "prettierd" }, ["typescriptreact"] = { "prettierd" }, ["yaml"] = { "prettierd" } } })

-- LSP {{{
do
  local __lspServers = { { ["name"] = "yamlls" }, { ["name"] = "tsserver" }, { ["name"] = "tailwindcss" }, { ["name"] = "nil_ls" }, { ["name"] = "marksman" }, { ["extraOptions"] = { ["settings"] = { ["Lua"] = { ["diagnostics"] = { ["globals"] = { "vim" } }, ["runtime"] = { ["version"] = "LuaJIT" }, ["telemetry"] = { ["enable"] = false }, ["workspace"] = { ["checkThirdParty"] = false, ["library"] = { vim.api.nvim_get_runtime_file('', true) } } } } }, ["name"] = "lua_ls" }, { ["extraOptions"] = { ["cmd"] = { "/nix/store/ckj3ibxszbq40d2qr9l6fr6g05yjxgv8-vscode-langservers-extracted-4.8.0/bin/vscode-json-language-server", "--stdio" } }, ["name"] = "jsonls" }, { ["extraOptions"] = { ["cmd"] = { "/nix/store/ckj3ibxszbq40d2qr9l6fr6g05yjxgv8-vscode-langservers-extracted-4.8.0/bin/vscode-html-language-server", "--stdio" } }, ["name"] = "html" }, { ["extraOptions"] = { ["cmd"] = { "/nix/store/ckj3ibxszbq40d2qr9l6fr6g05yjxgv8-vscode-langservers-extracted-4.8.0/bin/vscode-eslint-language-server", "--stdio" } }, ["name"] = "eslint" }, { ["name"] = "emmet_ls" }, { ["extraOptions"] = { ["cmd"] = { "/nix/store/kw26mrz6yn3q1b94arnf0gnrnlizz7an-dockerfile-language-server-nodejs-0.11.0/bin/docker-langserver", "--stdio" } }, ["name"] = "dockerls" }, { ["extraOptions"] = { ["cmd"] = { "/nix/store/ckj3ibxszbq40d2qr9l6fr6g05yjxgv8-vscode-langservers-extracted-4.8.0/bin/vscode-css-language-server", "--stdio" } }, ["name"] = "cssls" }, { ["name"] = "cmake" }, { ["name"] = "ccls" }, { ["name"] = "bashls" } }
  local __lspOnAttach = function(client, bufnr)

  end
  local __lspCapabilities = function()
    capabilities = vim.lsp.protocol.make_client_capabilities()



    return capabilities
  end

  local __setup = {
    on_attach = __lspOnAttach,
    capabilities = __lspCapabilities()
  }

  for i, server in ipairs(__lspServers) do
    if type(server) == "string" then
      require('lspconfig')[server].setup(__setup)
    else
      local options = server.extraOptions

      if options == nil then
        options = __setup
      else
        options = vim.tbl_extend("keep", options, __setup)
      end

      require('lspconfig')[server.name].setup(options)
    end
  end

  vim.g.rustaceanvim = {
    ["auto_focus"] = true,
    ["dap"] = { ["autoload_configurations"] = true },
    ["tools"] = {
      ["executor"] = "toggleterm",
      ["on_initialized"] = function()
        vim.notify("successfully initialized rust-analyzer")
      end
    }
  }

  require('lspconfig')["nxls"].setup({
    cmd = { "/nix/store/45jh7xfdwvyamxl35v1fl4brlcprdqaw-nxls/bin/nxls", "--stdio" }
  })
end
-- }}}

require('ts_context_commentstring').setup({})

require('nvim-treesitter.configs').setup({ ["autotag"] = { ["enable"] = true }, ["highlight"] = { ["enable"] = true } })

__lint = require('lint')
__lint.linters_by_ft = {
  ["javascript"] = { "eslint_d" },
  ["javascriptreact"] = { "eslint_d" },
  ["typescript"] = { "eslint_d" },
  ["typescriptreact"] = { "eslint_d" }
}

require('gitsigns').setup({})


require('nvim-tree').setup({
  ["auto_reload_on_write"] = true,
  ["diagnostics"] = { ["enable"] = true, ["show_on_dirs"] = true },
  ["disable_netrw"] = true,
  ["hijack_cursor"] = true,
  ["hijack_directories"] = { ["auto_open"] = false },
  ["modified"] = { ["enable"] = true },
  ["on_attach"] = function(bufnr)
    local api = require("nvim-tree.api")
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    local function edit_or_open()
      local node = api.tree.get_node_under_cursor()

      if node.nodes ~= nil then
        -- expand or collapse folder
        api.node.open.edit()
      else
        -- open file
        api.node.open.edit()
      end
    end

    -- open as vsplit on current node
    local function vsplit_preview()
      local node = api.tree.get_node_under_cursor()

      if node.nodes ~= nil then
        -- expand or collapse folder
        api.node.open.edit()
      else
        -- open file as vsplit
        api.node.open.vertical()
      end

      -- Finally refocus on tree if it was lost
      api.tree.focus()
    end
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
    vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
    vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close folder"))
    vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
  end
  ,
  ["prefer_startup_root"] = true,
  ["reload_on_bufenter"] = true,
  ["respect_buf_cwd"] = true,
  ["sync_root_with_cwd"] = true,
  ["update_focused_file"] = { ["enable"] = true, ["update_root"] = true },
  ["view"] = { ["centralize_selection"] = true, ["width"] = { ["max"] = -1, ["min"] = 30, ["padding"] = 1 } }
})

do
  local cmp = require('cmp')
  cmp.setup({
    ["completion"] = { ["autocomplete"] = { require('cmp.types').cmp.TriggerEvent.TextChanged } },
    ["mapping"] = {
      ["<C-h>"] = cmp.mapping.scroll_docs(4),
      ["<C-x>"] = cmp.mapping.scroll_docs(-4),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        local luasnip = require 'luasnip'
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end
      , { "i", "s" }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        local luasnip = require 'luasnip'
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand();
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end
      , { "i", "s" })
    },
    ["preselect"] = cmp.PreselectMode.None,
    ["snippet"] = {
      ["expand"] = function(args)
        require('luasnip').lsp_expand(args.body)
      end
    },
    ["sources"] = { {
      ["entryFilter"] = function(entry, ctx)
        return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
      end
      ,
      ["name"] = "nvim_lsp"
    }, { ["name"] = "luasnip" }, { ["name"] = "path" }, { ["name"] = "crates" }, { ["name"] = "lua" }, { ["name"] = "tmux" }, { ["name"] = "npm" } }
  })
end

require('bufferline').setup { ["options"] = { ["always_show_bufferline"] = false, ["buffer_close_icon"] = "", ["close_icon"] = "", ["diagnostics"] = "nvim_lsp", ["hover"] = { ["enabled"] = true } } }

-- Set up keybinds {{{
do
  local __nixvim_binds = { { ["action"] = ":Bdelete<CR>", ["key"] = "<leader>q", ["mode"] = "n", ["options"] = { ["silent"] = true } }, { ["action"] = ":Bwipeout<CR>", ["key"] = "<leader>w", ["mode"] = "n", ["options"] = { ["silent"] = true } }, { ["action"] = vim.diagnostic.goto_next, ["key"] = "<leader>j", ["mode"] = "n", ["options"] = { ["silent"] = true } }, { ["action"] = vim.diagnostic.goto_prev, ["key"] = "<leader>k", ["mode"] = "n", ["options"] = { ["silent"] = true } }, { ["action"] = vim.lsp.buf.hover, ["key"] = "K", ["mode"] = "n", ["options"] = { ["silent"] = true } }, { ["action"] = vim.lsp.buf.declaration, ["key"] = "gD", ["mode"] = "n", ["options"] = { ["silent"] = true } }, { ["action"] = vim.lsp.buf.definition, ["key"] = "gd", ["mode"] = "n", ["options"] = { ["silent"] = true } }, { ["action"] = vim.lsp.buf.implementation, ["key"] = "gi", ["mode"] = "n", ["options"] = { ["silent"] = true } }, { ["action"] = vim.lsp.buf.references, ["key"] = "gr", ["mode"] = "n", ["options"] = { ["silent"] = true } }, { ["action"] = vim.lsp.buf.type_definition, ["key"] = "gt", ["mode"] = "n", ["options"] = { ["silent"] = true } }, { ["action"] = "<c-u>zz", ["key"] = "<c-u>", ["mode"] = "n", ["options"] = { ["desc"] = "Navigate up with centered cursor", ["silent"] = true } }, { ["action"] = "<c-d>zz", ["key"] = "<c-d>", ["mode"] = "n", ["options"] = { ["desc"] = "Navigate down with centered cursor", ["silent"] = true } }, { ["action"] = ":let @/=\"\"<CR>", ["key"] = "<leader>h", ["mode"] = "n", ["options"] = { ["desc"] = "Clear highlights and search term", ["silent"] = true } }, { ["action"] = ":bnext<CR>", ["key"] = "<Tab>", ["mode"] = "n", ["options"] = { ["desc"] = "Next buffer", ["silent"] = true } }, { ["action"] = ":bprevious<CR>", ["key"] = "<S-Tab>", ["mode"] = "n", ["options"] = { ["desc"] = "Previous buffer", ["silent"] = true } }, { ["action"] = ":%bd|e#|bd#<CR>|'\"", ["key"] = "<leader>o", ["mode"] = "n", ["options"] = { ["desc"] = "Close all buffers except current", ["silent"] = true } }, { ["action"] = ":wincmd k<CR>", ["key"] = "<c-k>", ["mode"] = "n", ["options"] = { ["desc"] = "Jump to top split", ["silent"] = true } }, { ["action"] = ":wincmd j<CR>", ["key"] = "<c-j>", ["mode"] = "n", ["options"] = { ["desc"] = "Jump to bottom split", ["silent"] = true } }, { ["action"] = ":wincmd h<CR>", ["key"] = "<c-h>", ["mode"] = "n", ["options"] = { ["desc"] = "Jump to left split", ["silent"] = true } }, { ["action"] = ":wincmd l<CR>", ["key"] = "<c-l>", ["mode"] = "n", ["options"] = { ["desc"] = "Jump to right split", ["silent"] = true } }, {
    ["action"] = function()
      require("conform").format({ async = true, lsp_fallback = true })
    end
    ,
    ["key"] = "<leader>i",
    ["mode"] = "n",
    ["options"] = { ["desc"] = "Format", ["silent"] = true }
  }, { ["action"] = ":DapToggleBreakpoint<CR>", ["key"] = "<leader>db", ["mode"] = "n", ["options"] = { ["desc"] = "Toggle breakpoint", ["silent"] = true } }, { ["action"] = ":lua require('dapui').open({reset = true})<CR>", ["key"] = "<leader>dr", ["mode"] = "n", ["options"] = { ["desc"] = "Reset UI", ["silent"] = true } }, { ["action"] = ":DapContinue<CR>", ["key"] = "<leader>dc", ["mode"] = "n", ["options"] = { ["desc"] = "Continue", ["silent"] = true } }, { ["action"] = ":DapTerminate<CR>", ["key"] = "<leader>dk", ["mode"] = "n", ["options"] = { ["desc"] = "Kill debugging session", ["silent"] = true } }, { ["action"] = ":DapStepInto<CR>", ["key"] = "<leader>dsi", ["mode"] = "n", ["options"] = { ["desc"] = "Step into function call", ["silent"] = true } }, { ["action"] = ":DapStepOut<CR>", ["key"] = "<leader>dsu", ["mode"] = "n", ["options"] = { ["desc"] = "Step out of function call", ["silent"] = true } }, { ["action"] = ":DapStepOver<CR>", ["key"] = "<leader>dso", ["mode"] = "n", ["options"] = { ["desc"] = "Step over function call", ["silent"] = true } }, { ["action"] = ":lua require('dapui').toggle()<CR>", ["key"] = "<leader>td", ["mode"] = "n", ["options"] = { ["desc"] = "Toggle dapui", ["silent"] = true } }, {
    ["action"] = function()
      require("fine-cmdline").open({ default_value = "" })
    end
    ,
    ["key"] = ":",
    ["mode"] = "n",
    ["options"] = { ["desc"] = "Open FineCmdLine", ["silent"] = true }
  }, {
    ["action"] = function()
      require('haskell-tools').repl.toggle()
    end
    ,
    ["key"] = "<leader>th",
    ["mode"] = "n",
    ["options"] = { ["desc"] = "Toggle Cabal REPL", ["silent"] = true }
  }, {
    ["action"] = function()
      vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
    end
    ,
    ["key"] = "<leader>n",
    ["mode"] = "n",
    ["options"] = { ["desc"] = "Toggle inlay hints", ["silent"] = true }
  }, {
    ["action"] = function()
      vim.lsp.buf.code_action()
    end
    ,
    ["key"] = "ca",
    ["mode"] = "n",
    ["options"] = { ["desc"] = "Select code action", ["silent"] = true }
  }, { ["action"] = ":NvimTreeToggle<CR>",           ["key"] = "<leader>e",  ["mode"] = "n", ["options"] = { ["desc"] = "Toggle nvim-tree", ["silent"] = true } }, { ["action"] = ":Neotest run<CR>", ["key"] = "<leader>rr", ["mode"] = "n", ["options"] = { ["desc"] = "Run nearest test", ["silent"] = true } }, {
    ["action"] = function()
      require('neotest').run.run({ strategy = "dap" })
    end,
    ["key"] = "<leader>rd",
    ["mode"] = "n",
    ["options"] = { ["desc"] = "Run nearest test", ["silent"] = true }
  }, { ["action"] = ":Neotest output-panel toggle<CR>", ["key"] = "<leader>to", ["mode"] = "n", ["options"] = { ["desc"] = "Toggle test output panel", ["silent"] = true } }, { ["action"] = ":Neotest summary toggle<CR>", ["key"] = "<leader>ts", ["mode"] = "n", ["options"] = { ["desc"] = "Toggle test summary", ["silent"] = true } }, { ["action"] = ":Neotest jump next<CR>", ["key"] = "<leader>rn", ["mode"] = "n", ["options"] = { ["desc"] = "Jump to next test", ["silent"] = true } }, { ["action"] = ":Neotest jump prev<CR>", ["key"] = "<leader>rp", ["mode"] = "n", ["options"] = { ["desc"] = "Jump to previous test", ["silent"] = true } }, { ["action"] = ":Neotest run file<CR>", ["key"] = "<leader>ra", ["mode"] = "n", ["options"] = { ["desc"] = "Run all tests", ["silent"] = true } }, { ["action"] = ":TroubleToggle<CR>", ["key"] = "<leader>tt", ["mode"] = "n", ["options"] = { ["desc"] = "Toggle trouble", ["silent"] = true } }, { ["action"] = ":Telescope nx actions<CR>", ["key"] = "<leader>nxa", ["mode"] = "n", ["options"] = { ["desc"] = "Find nx actions", ["silent"] = true } }, { ["action"] = ":Telescope nx generators<CR>", ["key"] = "<leader>nxg", ["mode"] = "n", ["options"] = { ["desc"] = "Find nx generators", ["silent"] = true } }, { ["action"] = ":Telescope nx affected<CR>", ["key"] = "<leader>nxf", ["mode"] = "n", ["options"] = { ["desc"] = "Find nx affected targets", ["silent"] = true } }, { ["action"] = ":Telescope nx run_many<CR>", ["key"] = "<leader>nxm", ["mode"] = "n", ["options"] = { ["desc"] = "Find nx run many targets", ["silent"] = true } }, { ["action"] = "function()\n      lint.try_lint()\nend\n", ["key"] = "<leader>l", ["mode"] = "n", ["options"] = { ["desc"] = "Trigger linting for current file", ["silent"] = true } }, {
    ["action"] = function()
      local focusable_windows = vim.tbl_filter(
        function(win) return vim.api.nvim_win_get_config(win).focusable end,
        vim.api.nvim_tabpage_list_wins(0)
      )
      require('leap').leap { target_windows = focusable_windows }
    end
    ,
    ["key"] = "s",
    ["mode"] = "n"
  }, { ["action"] = ":TagbarToggle<CR>",      ["key"] = "<leader>tb", ["mode"] = "n", ["options"] = { ["desc"] = "Toggle tagbar", ["silent"] = true } }, { ["action"] = ":SearchBoxIncSearch<CR>", ["key"] = "/", ["mode"] = "n", ["options"] = { ["desc"] = "Search incrementally", ["silent"] = true } }, { ["action"] = ":SearchBoxIncSearch visual_mode=true<CR>", ["key"] = "/", ["mode"] = "v", ["options"] = { ["desc"] = "Search incrementally", ["silent"] = true } }, { ["action"] = ":SearchBoxReplace<CR>", ["key"] = "<leader>s", ["mode"] = "n", ["options"] = { ["desc"] = "Search and replace", ["silent"] = true } }, { ["action"] = ":SearchBoxIncSearch visual_mode=true<CR>", ["key"] = "<leader>s", ["mode"] = "v", ["options"] = { ["desc"] = "Search and replace", ["silent"] = true } }, { ["action"] = "function()\n  vim.cmd.RustLsp('codeAction')\nend\n", ["key"] = "<leader>a", ["mode"] = "n", ["options"] = { ["desc"] = "Rust Action", ["silent"] = true } }, { ["action"] = ":RustLsp runnables<CR>", ["key"] = "<leader>frr", ["mode"] = "n", ["options"] = { ["desc"] = "Find rust runnables", ["silent"] = true } }, { ["action"] = ":RustLsp testables<CR>", ["key"] = "<leader>frt", ["mode"] = "n", ["options"] = { ["desc"] = "Find rust testables", ["silent"] = true } }, { ["action"] = ":RustLsp debuggables<CR>", ["key"] = "<leader>frd", ["mode"] = "n", ["options"] = { ["desc"] = "Find rust debuggables", ["silent"] = true } }, { ["action"] = ":RustLsp testables last<CR>", ["key"] = "<leader>fra", ["mode"] = "n", ["options"] = { ["desc"] = "Run last rust test", ["silent"] = true } }, { ["action"] = ":ToggleTerm<CR>", ["key"] = "<leader>tm", ["mode"] = "n", ["options"] = { ["desc"] = "Toggle terminal", ["silent"] = true } }, {
    ["action"] = function()
      require('telescope').extensions.manix.manix({
        manix_args = {
          '--source', 'nixpkgs-doc',
          '--source', 'nixpkgs-comments',
          '--source', 'nixpkgs-tree',
          '--source', 'hm-options',
          '--source', 'nixos-options',
        },
        cword = false
      })
    end,
    ["key"] = "<leader>fn",
    ["mode"] = "n",
    ["options"] = { ["desc"] = "Nix documentation", ["silent"] = true }
  }, { ["action"] = ":Telescope find_files<CR>", ["key"] = "<leader>ff", ["mode"] = "n", ["options"] = { ["desc"] = "Find files", ["silent"] = true } }, { ["action"] = ":Telescope live_grep<CR>", ["key"] = "<leader>fg", ["mode"] = "n", ["options"] = { ["desc"] = "Live grep", ["silent"] = true } }, { ["action"] = ":Telescope projects<CR>", ["key"] = "<leader>fp", ["mode"] = "n", ["options"] = { ["desc"] = "Projects", ["silent"] = true } } }
  for i, map in ipairs(__nixvim_binds) do
    vim.keymap.set(map.mode, map.key, map.action, map.options)
  end
end
-- }}}

vim.filetype.add({ ["extension"] = { ["rasi"] = "rasi" }, ["pattern"] = { [".*/hyprland%.conf"] = "hyprlang" } })


-- Set up autocommands {{
do
  local __nixvim_autocommands = { {
    ["callback"] = function()
      require('lint').try_lint()
    end
    ,
    ["event"] = "BufWritePost"
  }, { ["command"] = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif", ["event"] = "BufEnter", ["nested"] = true }, {
    ["callback"] = function()
      local flake_found = false;
      local direnv_found = false;
      local cwd = vim.fn.getcwd();
      local files = vim.split(vim.fn.glob(cwd .. "/*") .. '\n' .. vim.fn.glob(cwd .. "/.[^.]*", 1), '\n')
      local flake = cwd .. "/" .. "flake.nix"
      local direnv = cwd .. "/" .. ".envrc"
      for _, file in pairs(files) do
        if file == flake then
          flake_found = true;
        end
        if file == direnv then
          direnv_found = true;
        end
      end
      if flake_found and direnv_found then
        require("nix-develop").nix_develop({})
      end
    end
    ,
    ["event"] = { "DirChanged" }
  }, {
    ["callback"] = function()
      vim.cmd.hi('Cursor', 'blend=100')
      vim.opt.guicursor:append { 'a:Cursor/lCursor' }
    end
    ,
    ["event"] = { "User" },
    ["pattern"] = { "LeapEnter" }
  }, {
    ["callback"] = function()
      vim.cmd.hi('Cursor', 'blend=0')
      vim.opt.guicursor:append { 'a:Cursor/lCursor' }
    end
    ,
    ["event"] = { "User" },
    ["pattern"] = { "LeapLeave" }
  } }

  for _, autocmd in ipairs(__nixvim_autocommands) do
    vim.api.nvim_create_autocmd(
      autocmd.event,
      {
        group    = autocmd.group,
        pattern  = autocmd.pattern,
        buffer   = autocmd.buffer,
        desc     = autocmd.desc,
        callback = autocmd.callback,
        command  = autocmd.command,
        once     = autocmd.once,
        nested   = autocmd.nested
      }
    )
  end
end
-- }}

local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
vim.api.nvim_set_hl(0, "red", { fg = "#DD2E44" })
vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })
vim.fn.sign_define('DapBreakpoint', { text = '•', texthl = 'red', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text = '•', texthl = 'blue', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text = '•', texthl = 'orange', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapStopped', { text = '•', texthl = 'green', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text = '•', texthl = 'yellow', numhl = 'DapBreakpoint' })

require("dressing").setup({
  input = {
    -- Set to false to disable the vim.ui.input implementation
    enabled = true,

    -- Default prompt string
    default_prompt = "Input",

    -- Trim trailing `:` from prompt
    trim_prompt = true,

    -- Can be 'left', 'right', or 'center'
    title_pos = "left",

    -- When true, <Esc> will close the modal
    insert_only = true,

    -- When true, input will start in insert mode.
    start_in_insert = true,

    -- These are passed to nvim_open_win
    border = "rounded",
    -- 'editor' and 'win' will default to being centered
    relative = "cursor",

    -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    prefer_width = 40,
    width = nil,
    -- min_width and max_width can be a list of mixed types.
    -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
    max_width = { 140, 0.9 },
    min_width = { 20, 0.2 },

    buf_options = {},
    win_options = {
      -- Disable line wrapping
      wrap = false,
      -- Indicator for when text exceeds window
      list = true,
      listchars = "precedes:…,extends:…",
      -- Increase this for more context when text scrolls off the window
      sidescrolloff = 0,
    },

    -- Set to `false` to disable
    mappings = {
      n = {
        ["<Esc>"] = "Close",
        ["<CR>"] = "Confirm",
      },
      i = {
        ["<C-c>"] = "Close",
        ["<CR>"] = "Confirm",
        ["<Up>"] = "HistoryPrev",
        ["<Down>"] = "HistoryNext",
      },
    },

    override = function(conf)
      -- This is the config that will be passed to nvim_open_win.
      -- Change values here to customize the layout
      return conf
    end,

    -- see :help dressing_get_config
    get_config = nil,
  },
  select = {
    -- Set to false to disable the vim.ui.select implementation
    enabled = true,

    -- Priority list of preferred vim.select implementations
    backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

    -- Trim trailing `:` from prompt
    trim_prompt = true,

    -- Options for telescope selector
    -- These are passed into the telescope picker directly. Can be used like:
    -- telescope = require('telescope.themes').get_ivy({...})
    telescope = nil,

    -- Options for fzf selector
    fzf = {
      window = {
        width = 0.5,
        height = 0.4,
      },
    },

    -- Options for fzf-lua
    fzf_lua = {
      -- winopts = {
      --   height = 0.5,
      --   width = 0.5,
      -- },
    },

    -- Options for nui Menu
    nui = {
      position = "50%",
      size = nil,
      relative = "editor",
      border = {
        style = "rounded",
      },
      buf_options = {
        swapfile = false,
        filetype = "DressingSelect",
      },
      win_options = {
        winblend = 0,
      },
      max_width = 80,
      max_height = 40,
      min_width = 40,
      min_height = 10,
    },

    -- Options for built-in selector
    builtin = {
      -- Display numbers for options and set up keymaps
      show_numbers = true,
      -- These are passed to nvim_open_win
      border = "rounded",
      -- 'editor' and 'win' will default to being centered
      relative = "editor",

      buf_options = {},
      win_options = {
        cursorline = true,
        cursorlineopt = "both",
      },

      -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- the min_ and max_ options can be a list of mixed types.
      -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
      width = nil,
      max_width = { 140, 0.8 },
      min_width = { 40, 0.2 },
      height = nil,
      max_height = 0.9,
      min_height = { 10, 0.2 },

      -- Set to `false` to disable
      mappings = {
        ["<Esc>"] = "Close",
        ["<C-c>"] = "Close",
        ["<CR>"] = "Confirm",
      },

      override = function(conf)
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        return conf
      end,
    },

    -- Used to override format_item. See :help dressing-format
    format_item_override = {},

    -- see :help dressing_get_config
    get_config = nil,
  },
})

require('fine-cmdline').setup({
  cmdline = {
    enable_keymaps = true,
    smart_history = true,
    prompt = ':'
  },
  popup = {
    position = {
      row = '50%',
      col = '50%',
    },
    size = {
      width = '60%',
    },
    border = {
      style = 'rounded',
    },
    win_options = {
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
    },
  },
  hooks = {
    before_mount = function(input)
      -- code
    end,
    after_mount = function(input)
      -- code
    end,
    set_keymaps = function(imap, feedkeys)
      -- code
    end
  }
})

require('telescope').load_extension('ht')

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
      [vim.diagnostic.severity.INFO] = 'InformationMsg',
      [vim.diagnostic.severity.HINT] = 'HintMsg',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
      [vim.diagnostic.severity.INFO] = 'InformationMsg',
      [vim.diagnostic.severity.HINT] = 'HintMsg',
    },
  }
})

local ls = require('luasnip')
local haskell_snippets = require('haskell-snippets').all
ls.add_snippets('haskell', haskell_snippets, { key = 'haskell' })

require('neotest').setup {
  adapters = {
    require('rustaceanvim.neotest'),
    require('neotest-haskell'),
    require('neotest-jest')({
      jestCommand = "jest",
      jestConfigFile = "jest.config.ts",
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
  }
}

require('nx').setup {
  nx_cmd_root = 'nx',
  command_runner = require('nx.command-runners').toggleterm_runner()
}

vim.keymap.del({ 'x', 'o' }, 'x')
vim.keymap.del({ 'x', 'o' }, 'X')

require('searchbox').setup({
  defaults = {
    reverse = false,
    exact = false,
    prompt = ' ',
    modifier = 'disabled',
    confirm = 'off',
    clear_matches = true,
    show_matches = false,
  },
  popup = {
    relative = 'win',
    position = {
      row = '5%',
      col = '95%',
    },
    size = 30,
    border = {
      style = 'rounded',
      text = {
        top = ' Search ',
        top_align = 'left',
      },
    },
    win_options = {
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
    },
  },
  hooks = {
    before_mount = function(input)
      -- code
    end,
    after_mount = function(input)
      -- code
    end,
    on_done = function(value, search_type)
      -- code
    end
  }
})

local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}
local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)
vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup { scope = { highlight = highlight } }
hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

local telescope = require('telescope')
telescope.load_extension('manix')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require 'lspconfig'.cssls.setup {
  capabilities = capabilities,
  settings = {
    css = {
      validate = false,
      lint = {
        unknownAtRules = "ignore"
      }
    },
    scss = {
      validate = false,
      lint = {
        unknownAtRules = "ignore"
      }
    },
    less = {
      validate = false,
      lint = {
        unknownAtRules = "ignore"
      }
    }
  }
}
