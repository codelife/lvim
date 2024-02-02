--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
Path = require('plenary.path')
lvim.log.level = "warn"
lvim.colorscheme = "dracula"
lvim.builtin.lualine.options.theme = "palenight"
lvim.builtin.lualine.style = "lvim"
local components = require "lvim.core.lualine.components"
lvim.builtin.lualine.sections.lualine_c = {
  components.diff,
  components.python_env,
  { "filename", path = 2 },
}
lvim.transparent_window = true
lvim.format_on_save = true
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = { only_current_line = true },
})
lvim.builtin.nvimtree.setup.view.width = 35
lvim.builtin.telescope.defaults.layout_config.width = 0.6
lvim.builtin.bufferline.options.show_buffer_close_icons = false
lvim.builtin.bufferline.options.sort_by = "relative_directory"
lvim.builtin.bufferline.options.numbers = "ordinal"
lvim.builtin.bufferline.options.diagnostics = true
lvim.builtin.bufferline.options.show_tab_indicators = false
lvim.builtin.bufferline.options.tab_size = 0
lvim.lsp.buffer_options.formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:2000})"

vim.opt.splitbelow = true
vim.opt.foldmethod = "expr" -- fold with nvim_treesitter
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false  -- no fold to be applied when open a file
vim.opt.foldlevel = 99
vim.opt.updatetime = 300
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 100
vim.opt.termguicolors = true

-- LunarVim use pyright as default lsp for python, disable default settings;
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
local pyright_opts = {
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end,
  },
  on_attach = function(client, _)
    client.server_capabilities.codeActionProvider = false
  end,
  single_file_support = true,
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = true
    },
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly", -- openFilesOnly, workspace
        typeCheckingMode = "standard",    -- off, basic, strict
        useLibraryCodeForTypes = true
      }
    }
  },
}
require("lvim.lsp.manager").setup("pyright", pyright_opts)

require('lspconfig').ruff_lsp.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = true
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end,
  init_options = {
    settings = {
      -- default settings config is in ~/.config/ruff/pyproject.toml for linux
      -- default settings config is in ~/Library/Application Support/ruff/pyproject.toml for mac
      -- also you can add config in your project root path
      args = {},
    }
  }
}
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.builtin.treesitter.rainbow = {
  enable = true,
  extended_mode = true,  -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  max_file_lines = 5000, -- Do not enable for files with more than n lines, int
}


lvim.autocommands = {
  {
    "FileType", -- see `:h autocmd-events`
    {
      group = "fugitive_setting",
      pattern = { "fugitive" }, -- see `:h autocmd-events`
      command = "map <buffer> gpp :Git push<CR>",
    }
  },
}

lvim.builtin.treesitter.textobjects.select = {
  enable = true,
  -- Automatically jump forward to textobj, similar to targets.vim
  lookahead = true,
  keymaps = {
    -- You can use the capture groups defined in textobjects.scm
    ["af"] = "@conditional.outer",
    ["if"] = "@conditional.inner",
    ["ic"] = "@comment.outer",
    ["il"] = "@loop.inner",
    ["al"] = "@loop.outer",
    ["ak"] = "@block.outer",
    ["ik"] = "@block.inner",
  }
}

lvim.builtin.gitsigns.opts.signs = {
  change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
  add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
  delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
  topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
  changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
}
-- gitsigns textobjects map
vim.api.nvim_set_keymap('i', '<c-a>', '<Home>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<c-e>', '<End>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gj', "<cmd>lua vim.diagnostic.goto_next()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gk', "<cmd>lua vim.diagnostic.goto_prev()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gn', "<cmd>lua vim.lsp.buf.rename()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gp', "<cmd>lua require('goto-preview').goto_preview_definition()<cr>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gq', "<cmd>lua require('goto-preview').close_all_win()<cr>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gi', "<cmd>lua require('goto-preview').goto_preview_implementation()<cr>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-p>', "<cmd>BufferLineCyclePrev<cr>", {})
vim.api.nvim_set_keymap('n', '<c-n>', "<cmd>BufferLineCycleNext<cr>", {})
vim.api.nvim_set_keymap('n', '<space>,', "%", {})
vim.api.nvim_set_keymap('n', '<space>y', "y$", {})
vim.api.nvim_set_keymap('n', ';w', "<cmd>w<cr>", {})
vim.api.nvim_set_keymap('n', ';q', "<cmd>BufferKill<cr>", {})
vim.api.nvim_set_keymap('n', '<M-k>', "", {})
vim.api.nvim_set_keymap('n', '<M-j>', "", {})
vim.api.nvim_set_keymap('v', '<M-k>', "", {})
vim.api.nvim_set_keymap('v', '<M-j>', "", {})
vim.api.nvim_set_keymap('v', 'ts', ":TranslateW<CR>", { noremap = true, silent = true })


vim.api.nvim_set_keymap('', 'f',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
  , {})
vim.api.nvim_set_keymap('', 'F',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
  , {})
vim.api.nvim_set_keymap('n', ';;', "<cmd>lua require'hop'.hint_words({ current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('n', 'w',
  "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>", {})
vim.api.nvim_set_keymap('n', 'b',
  "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<cr>", {})
vim.api.nvim_set_keymap('v', 'w',
  "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>", {})
vim.api.nvim_set_keymap('v', 'b',
  "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<cr>", {})

lvim.builtin.which_key.mappings["0"] = { "<cmd>BufferLineTogglePin <CR>", "Buffer pin" }
lvim.builtin.which_key.mappings["1"] = { "<cmd>BufferLineGoToBuffer 1<CR>", "goto buffer1" }
lvim.builtin.which_key.mappings["2"] = { "<cmd>BufferLineGoToBuffer 2<CR>", "goto buffer2" }
lvim.builtin.which_key.mappings["3"] = { "<cmd>BufferLineGoToBuffer 3<CR>", "goto buffer3" }
lvim.builtin.which_key.mappings["4"] = { "<cmd>BufferLineGoToBuffer 4<CR>", "goto buffer4" }
lvim.builtin.which_key.mappings["5"] = { "<cmd>BufferLineGoToBuffer 5<CR>", "goto buffer4" }
lvim.builtin.which_key.mappings["6"] = { "<cmd>BufferLineGoToBuffer 6<CR>", "goto buffer4" }
lvim.builtin.which_key.mappings["7"] = { "<cmd>BufferLineGoToBuffer 7<CR>", "goto buffer4" }
lvim.builtin.which_key.mappings["8"] = { "<cmd>BufferLineGoToBuffer 8<CR>", "goto buffer4" }
lvim.builtin.which_key.mappings["9"] = { "<cmd>BufferLineGoToBuffer 9<CR>", "goto buffer4" }
lvim.builtin.which_key.mappings["n"] = { "<cmd>Telescope frecency<CR>", "recent files" }
lvim.builtin.which_key.mappings["u"] = { "<cmd>UndotreeToggle<cr>", "Undo Tree" }
lvim.builtin.which_key.mappings["q"] = { "<cmd>close<CR>", 'quit' }
lvim.builtin.which_key.mappings["S"] = { "<cmd>lua require('spectre').open()<CR>", 'search' }
lvim.builtin.which_key.mappings["sw"] = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
  'search current word' }
lvim.builtin.which_key.mappings["sg"] = { "<cmd>lua require('spectre').open_file_search()<CR>", 'search in current file' }
lvim.builtin.which_key.mappings["dg"] = { "<Cmd>DogeGenerate<CR>", 'gen doc' }
lvim.builtin.which_key.mappings["ba"] = { "<cmd>Telescope buffers<cr>", "List buffers" }
lvim.builtin.which_key.mappings["bc"] = { "<cmd>BufferLinePickClose<cr>", "Buffer pick close" }
lvim.builtin.which_key.mappings["bs"] = { "<cmd>BufferLineSortByDirectory<cr>", "Sort buffer directory" }
lvim.builtin.which_key.mappings["pj"] = { "<cmd>Telescope projects<cr>", "Projects" }
lvim.builtin.which_key.mappings["sa"] = { "<cmd>SessionManager load_session<cr>", "Show all session" }
lvim.builtin.which_key.mappings["sc"] = { "<cmd>SessionManager load_current_dir_session<cr>",
  "Restore last session for CurrentDir" }
lvim.builtin.which_key.mappings["fd"] = { "<cmd>RnvimrToggle<cr>", 'ranger' }
lvim.builtin.which_key.mappings["ff"] = { "<cmd>Telescope git_files<cr>", "Find file" }
lvim.builtin.which_key.mappings["fh"] = { "<cmd>DiffviewFileHistory<cr>", "Show file commit history" }
lvim.builtin.which_key.mappings["gf"] = { "<cmd>Telescope live_grep<cr>", "Live grep" }
lvim.builtin.which_key.mappings["fw"] = { "<cmd>Telescope grep_string<cr>", "Searches word under cursor" }
lvim.builtin.which_key.mappings["fs"] = { "<cmd>Telescope yaml_schema<cr>", "select yaml_schema" }
lvim.builtin.which_key.mappings["lc"] = { "<cmd>lua require'telescope.builtin'.command_history{}<cr>", "Command history" }
lvim.builtin.which_key.mappings["la"] = { "<cmd>Telescope commands<cr>", "All commands" }
lvim.builtin.which_key.mappings["lt"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace symbol" }
lvim.builtin.which_key.mappings["lf"] = { "<cmd>Telescope search_history<cr>", "Search history" }
lvim.builtin.which_key.mappings["ls"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbol" }
lvim.builtin.which_key.mappings["lr"] = { "<cmd>lua require'telescope.builtin'.registers{}<cr>, ", "registers" }
lvim.builtin.which_key.mappings["lm"] = { "<cmd>Telescope macroscope<cr>", "macros" }
lvim.builtin.which_key.mappings["ll"] = { "<cmd>NvimTreeFindFile<cr>", "locate file" }
lvim.builtin.which_key.mappings["i"] = { "<cmd>IndentBlanklineToggle<cr>", "blankline toggle" }
lvim.builtin.which_key.mappings["td"] = { "<cmd>TodoTelescope<cr>", "List Todo" }
lvim.builtin.which_key.mappings["tt"] = { "<cmd>Vista!!<cr>", "Code Navigate" }
lvim.builtin.which_key.mappings["ts"] = { "<cmd>TranslateW<CR>", "Translate current word" }
lvim.builtin.which_key.mappings["tf"] = { "<cmd>LvimToggleFormatOnSave<cr>", "FormatOnSaveToggle" }
lvim.builtin.which_key.mappings["tn"] = { "<cmd>tabe<cr>", "New file" }
lvim.builtin.which_key.mappings["mp"] = { "<cmd>MarkdownPreview<cr>", "Markdown Preview " }
lvim.builtin.which_key.mappings["mg"] = { "<cmd>GenTocMarked<cr>", "Markdown GenTocMarked " }
lvim.builtin.which_key.mappings["mf"] = { "<cmd>PanguAll<cr>", "Markdown Text format" }

lvim.builtin.which_key.mappings["gd"] = { "<cmd>Gdiffsplit!<cr>", "git diff current file" }
lvim.builtin.which_key.mappings["ge"] = { "<c-w>h:q<cr>", "close left diff file" }
lvim.builtin.which_key.mappings["gv"] = { "<cmd>DiffviewOpen<cr>", "git diff view" }
lvim.builtin.which_key.mappings["gq"] = { "<cmd>DiffviewClose<cr>", "git diffview close" }
lvim.builtin.which_key.mappings["gs"] = { "<cmd>Git<cr>", "git status" }
lvim.builtin.which_key.mappings["gl"] = { "<cmd>Git blame<cr>", "git blame" }
lvim.builtin.which_key.mappings["gw"] = { "<cmd>GWrite<cr>", "git write" }
lvim.builtin.which_key.mappings["gr"] = { "<cmd>Gread<cr>", 'git read' }
lvim.builtin.which_key.mappings["gc"] = { "<cmd>Git commit<cr>", 'git commit' }
lvim.builtin.which_key.mappings["gp"] = { "<cmd>Git push<cr>", 'git push' }
lvim.builtin.which_key.mappings["gg"] = { "<cmd>diffget //2<cr>", 'diffget left' }
lvim.builtin.which_key.mappings["gh"] = { "<cmd>diffget //3<cr>", 'diffget right' }

-- Gitsigns map
lvim.builtin.which_key.mappings["j"] = { "<cmd>Gitsigns next_hunk<CR>", "next hunk" }
lvim.builtin.which_key.mappings["k"] = { "<cmd>Gitsigns prev_hunk<CR>", "pre hunk" }
lvim.builtin.which_key.mappings["py"] = { "<cmd>Telescope neoclip<cr>", "show clipboard" }
lvim.builtin.which_key.mappings['hs'] = { '<cmd>Gitsigns stage_hunk<CR>', "stage hunk" }
lvim.builtin.which_key.mappings['hr'] = { '<cmd>Gitsigns reset_hunk<CR>', "reset hunk" }
lvim.builtin.which_key.mappings['hS'] = { '<cmd>Gitsigns stage_buffer<CR>', "stage buffer" }
lvim.builtin.which_key.mappings['hu'] = { '<cmd>Gitsigns undo_stage_hunk<CR>', "undo stage hunk" }
lvim.builtin.which_key.mappings['hR'] = { '<cmd>Gitsigns reset_buffer<CR>', "reset buffer" }
lvim.builtin.which_key.mappings['hp'] = { '<cmd>Gitsigns preview_hunk<CR>', "preview hunk" }
lvim.builtin.which_key.mappings['hb'] = { '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', "blame line" }
lvim.builtin.which_key.mappings['tb'] = { '<cmd>TroubleToggle<CR>', "Troubleshoot" }
lvim.builtin.which_key.mappings['hd'] = { '<cmd>Gitsigns diffthis<CR>', "diff this" }
lvim.builtin.which_key.mappings['hD'] = { '<cmd>lua require"gitsigns".diffthis("~")<CR>', "diff HEAD" }

lvim.builtin.which_key.mappings["c"] = { "" }
lvim.builtin.which_key.mappings["ca"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code action" }
lvim.builtin.which_key.mappings["cd"] = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", 'code diagnostic' }
lvim.builtin.which_key.mappings["cf"] = { "<cmd>lua vim.lsp.buf.format({async=true})<cr>", 'code format' }
lvim.builtin.which_key.mappings["cl"] = { "<cmd>lua vim.lsp.codelens.run()<cr>" }

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "startify"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "go",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "proto",
  "sql",
  "vue",
  "hcl",
  "regex",
  "markdown",
  "graphql",
}
-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  -- { command = "black",     filetypes = { "python" }, extra_args = { "-l 120" } },
  { command = "gofumpt",   filetypes = { "go" } },
  { command = "golines",   filetypes = { "go" }, extra_args = { "-m 120" } },
  { command = "goimports", filetypes = { "go" } },
  { command = "sqlfmt",    filetypes = { "sql" } },
}

-- Additional Plugins
lvim.plugins = {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = { "VimEnter" },
    config = function()
      require("copilot").setup {
        ---@class copilot_config_panel
        panel = {
          enabled = true,
          auto_refresh = false,
          ---@type table<'accept'|'next'|'prev'|'dismiss', false|string>
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<c-k>",
          },
          layout = {
            position = "bottom",
            ratio = 0.4
          }
        },
        ---@class copilot_config_suggestion
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 100,
          ---@type table<'accept'|'next'|'prev'|'dismiss', false|string>
          keymap = {
            accept = "<C-l>",
            accept_word = false,
            accept_line = false,
            next = "<C-j>",
            prev = "<C-->",
            dismiss = "<C-c>",
          },
        },
        ---@type table<string, boolean>
        filetypes = {},
        copilot_node_command = "node",

        server_opts_overrides = {
          trace = "verbose",
          settings = {
            advanced = {
              listCount = 5,          -- #completions for panel
              inlineSuggestCount = 3, -- #completions for getCompletions
            }
          },
        }
      }
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua", "hrsh7th/nvim-cmp" },
    config = function()
      require("copilot_cmp").setup()
    end
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    "p00f/nvim-ts-rainbow", event = "BufRead",
  },
  {
    'sQVe/sort.nvim', event = "BufRead"
  },
  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "TroubleToggle",
    opts = {},
  },
  { 'tpope/vim-surround', event = "BufRead" },
  { 'tpope/vim-repeat',   event = "BufRead" },
  {
    -- easymotion
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
    end,
  },
  {
    -- ranger
    "kevinhwang91/rnvimr",
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
    end,
  },
  {
    "tpope/vim-fugitive",
  },
  { 'sindrets/diffview.nvim' },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require 'colorizer'.setup {
        'css',
        'javascript',
        'typescript',
        'html',
        'scss',
        'sass',
        'lua',
        'typescriptreact',
        'vue'
      }
    end
  },
  { "kkoomen/vim-doge",      build = ':call doge#install()' },
  {
    "rmagatti/goto-preview",
    lazy = true,
    config = function()
      require('goto-preview').setup {
        width = 121,             -- Width of the floating window
        height = 40,             -- Height of the floating window
        default_mappings = true, -- Bind default mappings
        debug = false,           -- Print debug information
        opacity = nil,           -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil,    -- A function taking two arguments, a buffer and a window to be ran as a hook.
        resizing_mappings = true,
      }
    end,
    keys = { "g" }
  },
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufRead", "BufNew" },
    config = function()
      require("bqf").setup({
        auto_enable = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
        },
        func_map = {
          vsplit = "",
          ptogglemode = "z,",
          stoggleup = "",
        },
        filter = {
          fzf = {
            action_for = { ["ctrl-s"] = "split" },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
          },
        },
      })
    end,
  },
  {
    "monaqa/dial.nvim",
    event = "BufRead",
    config = function()
      vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
      vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
      vim.api.nvim_set_keymap("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
      vim.api.nvim_set_keymap("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
      vim.api.nvim_set_keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
      vim.api.nvim_set_keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
      local augend = require("dial.augend")
      require("dial.config").augends:register_group {
        -- default augends used when no group name is specified
        default = {
          augend.integer.alias.decimal,  -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex,      -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.constant.alias.bool,    -- boolean value (true <-> false)
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
          augend.constant.new {
            elements = { "True", "False" },
            word = true,   -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
          },
          augend.constant.new {
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
          },
          augend.constant.new {
            elements = { "asc", "desc" },
            word = true,
            cyclic = true,
          },
        },
      }
    end
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = { "gopls", "pyright", "ruff_lsp", "taplo", "lua_ls", "yamlls", "volar", "jsonls", "sql_formatter",
          "golines", "gofumpt", "goimports", "golangci_lint_ls", "isort", "vimls" },
        automatic_installation = true,
      }
    end
  },
  {
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    dependencies = "hrsh7th/nvim-cmp",
    event = "InsertEnter",
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects', },
  { 'iamcco/markdown-preview.nvim',                build = 'cd app && yarn install',      ft = "markdown" },
  { 'mzlogin/vim-markdown-toc',                    ft = 'markdown', },
  { 'tpope/vim-markdown',                          ft = 'markdown' },
  { 'hotoo/pangu.vim',                             ft = { 'markdown', 'vimwiki', 'text' } },
  { "dhruvasagar/vim-table-mode",                  cmd = "TableModeToggle" },
  --[[ { "mg979/vim-visual-multi" }, ]]
  { 'mtdl9/vim-log-highlighting',                  ft = "log" },
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup()
    end
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("user.todo-comment")
    end,
  },
  {
    'liuchengxu/vista.vim',
    cmd = 'Vista',
    config = function()
      vim.g.vista_default_executive = 'nvim_lsp'
    end
  },
  { "simrat39/symbols-outline.nvim" },
  {
    "Shatur/neovim-session-manager",
    config = function()
      require("session_manager").setup(
        {
          sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'),               -- The directory where the session files will be saved.
          path_replacer = '__',                                                      -- The character to which the path separator will be replaced for session files.
          colon_replacer = '++',                                                     -- The character to which the colon symbol will be replaced for session files.
          autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
          autosave_last_session = true,                                              -- Automatically save last session on exit and on session switch.
          autosave_ignore_not_normal = true,                                         -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
          autosave_ignore_filetypes = {                                              -- All buffers of these file types will be closed before the session is saved.
            'gitcommit',
          },
          autosave_ignore_buftypes = { "nofile", "quikfix", "terminal" },
          autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
          max_path_length = 80,            -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
        }
      )
    end
  },
  { "tami5/sqlite.lua",             lazy = true },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("neoclip")
      require("telescope").load_extension("frecency")
      require('telescope').load_extension("macroscope")
      require("telescope").load_extension("yaml_schema")
      -- require("telescope").load_extension("dap")
    end
  },
  { 'mbbill/undotree',    cmd = 'UndotreeToggle', lazy = true },
  {
    "nvim-telescope/telescope-frecency.nvim",
  },
  { "windwp/nvim-spectre" },
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup({
        mapping = { "jk", "jj" },   -- a table with mappings to use
        timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
        clear_empty_lines = false,  -- clear line after escaping if there is only whitespace
        keys = "<Esc>",             -- keys used for escaping, if it is a function will use the result everytime
      })
    end
  },
  -- colorscheme
  { "Shatur/neovim-ayu" },
  { "hzchirs/vim-material", },
  { 'patstockwell/vim-monokai-tasty', },
  { "Mofiqul/dracula.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "sickill/vim-monokai" },
  {
    "someone-stole-my-name/yaml-companion.nvim",
    ft = "yaml",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      local cfg = require("yaml-companion").setup({
      })
      require("lspconfig")["yamlls"].setup(cfg)
      require("telescope").load_extension("yaml_schema")
    end,
  },
  {
    "AckslD/nvim-neoclip.lua",
    name = 'neoclip',
    config = function()
      require('neoclip').setup(
        {
          history = 500,
          enable_persistent_history = true,
          length_limit = 1048576,
          continuous_sync = true,
          db_path = "/tmp/.neoclip.sqlite3",
          enable_macro_history = true,
        }
      )
    end
  },
  { "stevearc/dressing.nvim" },
  {
    'voldikss/vim-translator',
    config = function()
      vim.g.translator_default_engines = { "bing" }
    end,
  },
  {
    'gelguy/wilder.nvim',
    config = function()
      local wilder = require('wilder')
      wilder.setup({ modes = { '/', '?' } })
      wilder.set_option('renderer', wilder.popupmenu_renderer({
        highlighter = wilder.basic_highlighter(),
      }))
    end,
  },
  {
    "sustech-data/wildfire.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("wildfire").setup()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    cmd = "IndentBlanklineToggle",
    config = function()
      vim.g.indent_blankline_char_list = { '|', '¦', '¦' }
      vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent2 guifg=#C678DD gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
      require("indent_blankline").setup {
        enabled = false,
        show_first_indent_level = false,
        show_current_context = false,
        use_treesitter = true,
        show_current_context_start = true,
        space_char_blankline = " ",
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
          "IndentBlanklineIndent3",
          "IndentBlanklineIndent4",
          "IndentBlanklineIndent5",
        }
      }
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("noice").setup({
        messages = {
          -- NOTE: If you enable messages, then the cmdline is enabled automatically.
          -- This is a current Neovim limitation.
          enabled = true,            -- enables the Noice messages UI
          view = "notify",           -- default view for messages
          view_error = "notify",     -- view for errors
          view_warn = "notify",      -- view for warnings
          view_history = "messages", -- view for :messages
          view_search = false,       -- view for search count messages. Set to `false` to disable
        },                           -- add any options here
        lsp = {
          progress = {
            enabled = false,
          },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        views = {
          mini = {
            backend = "mini",
            relative = "editor",
            align = "message-right",
            timeout = 1300,
            reverse = true,
            focusable = false,
            position = {
              row = -1,
              col = 0,
              -- col = 0,
            },
            size = "auto",
            border = {
              style = "none",
            },
            zindex = 60,
            win_options = {
              winblend = 30,
              winhighlight = {
                Normal = "NoiceMini",
                IncSearch = "",
                Search = "",
              },
            },
          },
          notify = {
            timeout = 1800,
          },
        },
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          long_message_to_split = true, -- long messages will be sent to a split
        },
      })
      require("notify").setup({
        background_colour = "#181B24",
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
}
lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })
-- :let @p='<esc>0i"<Esc>i"j'
