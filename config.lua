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
lvim.colorscheme = "vim-monokai-tasty"
lvim.builtin.lualine.options.theme = "palenight"
lvim.builtin.lualine.style = "lvim"
lvim.transparent_window = true
lvim.format_on_save = true
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.automatic_servers_installation = true
lvim.lsp.installer.setup.automatic_installation = true
vim.diagnostic.config({
  virtual_text = false,
})
lvim.builtin.nvimtree.setup.view.width = 35
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 120
lvim.builtin.telescope.defaults.layout_config.vertical.mirror = false
lvim.builtin.telescope.defaults.layout_config.width = 0.85
lvim.builtin.bufferline.options.show_buffer_close_icons = false
lvim.builtin.bufferline.options.sort_by = "directory"
vim.opt.splitbelow = true
vim.opt.foldmethod = "expr" -- fold with nvim_treesitter
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true   -- no fold to be applied when open a file
vim.opt.foldlevel = 99
vim.opt.updatetime = 300
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 100
vim.opt.termguicolors = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
--[[ lvim.builtin.treesitter.matchup['enable'] = true ]]
lvim.builtin.comment.pre_hook = function(ctx)
  local U = require 'Comment.utils'

  local location = nil
  if ctx.ctype == U.ctype.block then
    location = require('ts_context_commentstring.utils').get_cursor_location()
  elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
    location = require('ts_context_commentstring.utils').get_visual_start_location()
  end

  return require('ts_context_commentstring.internal').calculate_commentstring {
    key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
    location = location,
  }
end

lvim.builtin.treesitter.rainbow = {
  enable = true,
  extended_mode = true,  -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  max_file_lines = 3000, -- Do not enable for files with more than n lines, int
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
vim.api.nvim_set_keymap('n', '<space>de', "D", {})
vim.api.nvim_set_keymap('n', '<space>ce', "C", {})
vim.api.nvim_set_keymap('n', ';w', "<cmd>w<cr>", {})
vim.api.nvim_set_keymap('n', ';q', "<cmd>BufferKill<cr>", {})
vim.api.nvim_set_keymap('n', ';h', "<cmd>nohlsearch<cr>", {})
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
vim.api.nvim_set_keymap('v', ';;', "<cmd>lua require'hop'.hint_words({ current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('n', 'w',
  "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>", {})
vim.api.nvim_set_keymap('n', 'b',
  "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<cr>", {})
vim.api.nvim_set_keymap('v', 'w',
  "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>", {})
vim.api.nvim_set_keymap('v', 'b',
  "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<cr>", {})
vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
vim.api.nvim_set_keymap('v', 'r', '<Plug>SnipRun', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>co', '<Plug>SnipRunOperator', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>cr', '<Plug>SnipRun', { silent = true })

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
lvim.builtin.which_key.mappings["ws"] = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
  'search current word' }
lvim.builtin.which_key.mappings["sg"] = { "<cmd>lua require('spectre').open_file_search()<CR>", 'search in current file' }
lvim.builtin.which_key.mappings["dd"] = { "<Cmd>BufferKill<CR>", 'Buffer kill' }
lvim.builtin.which_key.mappings["dg"] = { "<Cmd>DogeGenerate<CR>", 'gen doc' }
lvim.builtin.which_key.mappings["ba"] = { "<cmd>Telescope buffers<cr>", "List buffers" }
lvim.builtin.which_key.mappings["bc"] = { "<cmd>BufferLinePickClose<cr>", "Buffer pick close" }
lvim.builtin.which_key.mappings["bs"] = { "<cmd>BufferLineSortByExtension<cr>", "Sort buffer ext" }
lvim.builtin.which_key.mappings["pp"] = { "<cmd>Telescope projects<cr>", "Projects" }
lvim.builtin.which_key.mappings["ss"] = { "<cmd>SessionManager save_current_session<cr>", "Save current session" }
lvim.builtin.which_key.mappings["sa"] = { "<cmd>SessionManager load_session<cr>", "Show all session" }
lvim.builtin.which_key.mappings["sl"] = { "<cmd>SessionManager load_last_session<cr>", "Load last session" }
lvim.builtin.which_key.mappings["sc"] = { "<cmd>SessionManager load_current_dir_session<cr>",
  "Restore last session for CurrentDir" }
lvim.builtin.which_key.mappings["fd"] = { "<cmd>RnvimrToggle<cr>", 'ranger' }
lvim.builtin.which_key.mappings["ff"] = { "<cmd>Telescope git_files<cr>", "Find file" }
lvim.builtin.which_key.mappings["fh"] = { "<cmd>DiffviewFileHistory<cr>", "Show file commit history" }
lvim.builtin.which_key.mappings["fg"] = { "<cmd>Telescope live_grep<cr>", "Live grep" }
lvim.builtin.which_key.mappings["fw"] = { "<cmd>Telescope grep_string<cr>", "Searches word under cursor" }
lvim.builtin.which_key.mappings["fs"] = { "<cmd>Telescope yaml_schema<cr>", "select yaml_schema" }
lvim.builtin.which_key.mappings["lc"] = { "<cmd>lua require'telescope.builtin'.command_history{}<cr>", "Command history" }
lvim.builtin.which_key.mappings["la"] = { "<cmd>Telescope commands<cr>", "All commands" }
lvim.builtin.which_key.mappings["lt"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace symbol" }
lvim.builtin.which_key.mappings["lf"] = { "<cmd>Telescope search_history<cr>", "Search history" }
lvim.builtin.which_key.mappings["ls"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbol" }
lvim.builtin.which_key.mappings["lr"] = { "<cmd>lua require'telescope.builtin'.registers{}<cr>, ", "registers" }
lvim.builtin.which_key.mappings["lm"] = { "<cmd>Telescope macroscope<cr>", "macros" }
lvim.builtin.which_key.mappings["lh"] = { "<cmd>HopLine<cr>", "hop line" }
lvim.builtin.which_key.mappings["ll"] = { "<cmd>NvimTreeFindFile<cr>", "locate file" }
lvim.builtin.which_key.mappings["lj"] = { "<cmd>lua require'telescope.builtin'.jumplist{}<cr>", "jumplist" }
lvim.builtin.which_key.mappings["lk"] = { "<cmd>lua require'telescope.builtin'.keymaps{}<cr>", "keymaps" }
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

lvim.builtin.bufferline.options.numbers = "ordinal"
lvim.builtin.bufferline.options.diagnostics = false

lvim.builtin.which_key.mappings["c"] = { "" }
lvim.builtin.which_key.mappings["ca"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code action" }
lvim.builtin.which_key.mappings["cd"] = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", 'code diagnostic' }
lvim.builtin.which_key.mappings["cf"] = { "<cmd>lua vim.lsp.buf.format()<cr>", 'code format' }
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

lvim.builtin.indentlines.options.enabled = false
lvim.builtin.indentlines.options.show_current_context = true
lvim.builtin.indentlines.options.show_first_indent_level = false
lvim.builtin.indentlines.options.use_treesitter = true
vim.g.indent_blankline_char_list = { '|', '¦', '¦' }
vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#C678DD gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])

require("indent_blankline").setup {
  show_current_context = true,
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

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black",         filetypes = { "python" }, extra_args = { "-l 120" } },
  { command = "isort",         filetypes = { "python" } },
  { command = "gofumpt",       filetypes = { "go" } },
  { command = "goimports",     filetypes = { "go" } },
  { command = "golines",       filetypes = { "go" },     extra_args = { "-m 120" } },
  { command = "sql_formatter", filetypes = { "sql" } },
  { command = "buf",           filetypes = { "proto" } },
  {
    command = "prettier",
    extra_args = { "--print-with", "120" },
    filetypes = { "json", "html", "yaml" },
  },
  {
    command = "eslint_d",
    extra_args = { "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" },
    filetypes = { "javascript", "javascriptreact", "vue", "typescriptreact", "typescript" },
  }
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "flake8",
    filetypes = { "python" },
    extra_args = { "--max-line-length=120", "--ignore=F401,E121,E501,F403,W503", "--max-complexity=15" },
  },
  { command = "buf", filetypes = { "proto" } },
  --[[ { command = "golangci-lint", filetypes = { "go" } }, ]]
  --[[ { ]]
  --[[   command = "eslint_d", ]]
  --[[   filetypes = { "javascript", "typescript", "vue", "typescriptreact" }, ]]
  --[[ }, ]]
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
    after = { "copilot.lua", "nvim-cmp" },
    config = function()
      require("copilot_cmp").setup()
    end
  },
  {
    "p00f/nvim-ts-rainbow",
  },
  {
    'sQVe/sort.nvim',
  },
  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
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
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
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
    config = function()
      require 'colorizer'.setup {
        'css',
        'javascript',
        'lua',
        'typescriptreact',
        'vue'
      }
    end
  },
  { "kkoomen/vim-doge",      run = ':call doge#install()' },
  {
    "rmagatti/goto-preview",
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
    lock = true,
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
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup({ virtual_lines = true })
    end,
  },
  {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
    event = "InsertEnter",
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects', },
  { 'iamcco/markdown-preview.nvim',                run = 'cd app && yarn install',        ft = "markdown" },
  { 'mzlogin/vim-markdown-toc',                    ft = 'markdown', },
  { 'tpope/vim-markdown',                          ft = 'markdown' },
  { 'hotoo/pangu.vim',                             ft = { 'markdown', 'vimwiki', 'text' } },
  { 'mtdl9/vim-log-highlighting', },
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
  { 'michaelb/sniprun',             run = 'bash ./install.sh' },
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
          autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
          max_path_length = 80,            -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
        }
      )
    end
  },
  { "tami5/sqlite.lua" },
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
  { 'mbbill/undotree', cmd = 'UndotreeToggle' },
  {
    "nvim-telescope/telescope-frecency.nvim",
    requires = { "tami5/sqlite.lua" },
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
  { "hzchirs/vim-material", },
  { 'projekt0n/github-nvim-theme', },
  { "EdenEast/nightfox.nvim" },
  { 'phanviet/vim-monokai-pro', },
  { 'mhartington/oceanic-next', },
  { 'patstockwell/vim-monokai-tasty', },
  { 'KeitaNakamura/neodark.vim', },
  { "sainnhe/sonokai", },
  { "Mofiqul/dracula.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "sickill/vim-monokai" },
  {
    "someone-stole-my-name/yaml-companion.nvim",
    requires = {
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
    as = 'neoclip',
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
    'stevearc/oil.nvim',
    config = function() require('oil').setup() end
  },
  {
    'gelguy/wilder.nvim',
    config = function()
      local wilder = require('wilder')
      wilder.setup({ modes = { '/', '?' } })
      wilder.set_option('renderer', wilder.popupmenu_renderer({
        highlighter = wilder.basic_highlighter(),
        left = { ' ', wilder.popupmenu_devicons() },
        right = { ' ', wilder.popupmenu_scrollbar() },
      }))
    end,
  },
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        messages = {
          -- NOTE: If you enable messages, then the cmdline is enabled automatically.
          -- This is a current Neovim limitation.
          enabled = true,            -- enables the Noice messages UI
          view = "mini",             -- default view for messages
          view_error = "notify",     -- view for errors
          view_warn = false,         -- view for warnings
          view_history = "messages", -- view for :messages
          view_search = false,       -- view for search count messages. Set to `false` to disable
        },                           -- add any options here
        lsp = {
          progress = {
            enabled = false,
          }
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
        }
      })
      require("notify").setup({
        background_colour = "#181B24",
      })
    end,
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
}
lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })
