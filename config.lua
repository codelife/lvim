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
lvim.builtin.lualine.options.theme = "sonokai"
lvim.builtin.lualine.style = "lvim"
lvim.transparent_window = true
lvim.format_on_save = true
lvim.lsp.diagnostics.virtual_text = false
--[[ lvim.lsp.automatic_servers_installation = true ]]
--[[ lvim.lsp.installer.setup.automatic_installation = true ]]
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
vim.opt.foldenable = true -- no fold to be applied when open a file
vim.opt.foldlevel = 99
vim.opt.updatetime = 300
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 100
vim.opt.termguicolors = true
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd" })

vim.g.coq_settings = { ["clients.tabnine.enabled"] = true, ["auto_start"] = "shut-up",
  ["display.ghost_text.enabled"] = true }

--[[ lsp installed list ]]
--[[  black ]]
--[[  buf ]]
--[[  css-lsp ]]
--[[  dockerfile-language-server ]]
--[[  eslint_d ]]
--[[  fixjson ]]
--[[  flake8 ]]
--[[  gofumpt ]]
--[[  goimports ]]
--[[  golangci-lint ]]
--[[  golines ]]
--[[  gopls ]]
--[[  html-lsp ]]
--[[  isort ]]
--[[  json-lsp ]]
--[[  lua-language-server ]]
--[[  markdownlint ]]
--[[  prettier ]]
--[[  pyright ]]
--[[  shellcheck ]]
--[[  sql-formatter ]]
--[[  tailwindcss-language-server ]]
--[[  taplo ]]
--[[  typescript-language-server ]]
--[[  vim-language-server ]]
--[[  vue-language-server ]]
--[[  yaml-language-server ]]
--[[  yamlfmt ]]

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

lvim.builtin.treesitter.matchup['enable'] = true
--- vue script comment is error
-- lvim.builtin.treesitter.context_commentstring.enable = true
-- lvim.builtin.treesitter.context_commentstring.config = {
--         javascript = {
--                 __default = '// %s',
--                 jsx_element = '{/* %s */}',
--                 jsx_fragment = '{/* %s */}',
--                 jsx_attribute = '// %s',
--                 comment = '// %s'
--         }
-- }

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
  extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
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
vim.api.nvim_set_keymap('n', ';w', "<cmd>w<cr>", {})
vim.api.nvim_set_keymap('n', ';q', "<cmd>BufferKill<cr>", {})
vim.api.nvim_set_keymap('n', ';h', "<cmd>nohlsearch<cr>", {})
vim.api.nvim_set_keymap('n', '<M-k>', "", {})
vim.api.nvim_set_keymap('n', '<M-j>', "", {})
vim.api.nvim_set_keymap('v', '<M-k>', "", {})
vim.api.nvim_set_keymap('v', '<M-j>', "", {})
--[[ vim.api.nvim_set_keymap('n', 'ts', "viw:Translate ZH <CR>", { noremap = true, silent = true }) ]]
--[[ vim.api.nvim_set_keymap('v', 'ts', ":Translate ZH <CR>", { noremap = true, silent = true }) ]]


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
lvim.builtin.which_key.mappings["dg"] = { "<Cmd>Neogen<CR>", 'gen doc' }
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
lvim.builtin.which_key.mappings["lc"] = { "<cmd>lua require'telescope.builtin'.command_history{}<cr>", "Command history" }
lvim.builtin.which_key.mappings["la"] = { "<cmd>Telescope commands<cr>", "All commands" }
lvim.builtin.which_key.mappings["lt"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace symbol" }
lvim.builtin.which_key.mappings["lf"] = { "", "Search history" }
lvim.builtin.which_key.mappings["lf"] = { "<cmd>Telescope search_history<cr>", "Search history" }
lvim.builtin.which_key.mappings["ls"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbol" }
lvim.builtin.which_key.mappings["lr"] = { "", "registers" }
lvim.builtin.which_key.mappings["lr"] = { "<cmd>lua require'telescope.builtin'.registers{}<cr>, ", "registers" }
lvim.builtin.which_key.mappings["lm"] = { "<cmd>Telescope macroscope<cr>", "macros" }
lvim.builtin.which_key.mappings["lh"] = { "<cmd>HopLine<cr>", "hop line" }
lvim.builtin.which_key.mappings["ll"] = { "", "locate file" }
lvim.builtin.which_key.mappings["ll"] = { "<cmd>NvimTreeFindFile<cr>", "locate file" }
lvim.builtin.which_key.mappings["lj"] = { "<cmd>lua require'telescope.builtin'.jumplist{}<cr>", "jumplist" }
lvim.builtin.which_key.mappings["lk"] = { "<cmd>lua require'telescope.builtin'.keymaps{}<cr>", "keymaps" }
lvim.builtin.which_key.mappings["i"] = { "<cmd>IndentBlanklineToggle<cr>", "blankline toggle" }
lvim.builtin.which_key.mappings["td"] = { "<cmd>TodoTelescope<cr>", "List Todo" }
lvim.builtin.which_key.mappings["tt"] = { "<cmd>Vista!!<cr>", "Code Navigate" }
lvim.builtin.which_key.mappings["ts"] = { "viw:Translate ZH <CR>", "Translate current word" }
lvim.builtin.which_key.mappings["tf"] = { "<cmd>LvimToggleFormatOnSave<cr>", "FormatOnSaveToggle" }
lvim.builtin.which_key.mappings["mp"] = { "<cmd>MarkdownPreview<cr>", "Markdown Preview " }
lvim.builtin.which_key.mappings["mg"] = { "<cmd>GenTocMarked<cr>", "Markdown GenTocMarked " }
lvim.builtin.which_key.mappings["mf"] = { "<cmd>PanguAll<cr>", "Markdown Text format" }

lvim.builtin.which_key.mappings["gd"] = { "<cmd>Gdiffsplit!<cr>", "git diff current file" }
lvim.builtin.which_key.mappings["gv"] = { "<cmd>DiffviewOpen<cr>", "git diff view" }
lvim.builtin.which_key.mappings["gq"] = { "<cmd>DiffviewClose<cr>", "git diffview close" }
lvim.builtin.which_key.mappings["gs"] = { "", "git status" }
lvim.builtin.which_key.mappings["gs"] = { "<cmd>Neogit<cr>", "git status" }
lvim.builtin.which_key.mappings["gl"] = { "", "git blame" }
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
lvim.builtin.which_key.mappings["y"] = { "<cmd>Telescope neoclip<CR>", "show clipboard" }
lvim.builtin.which_key.mappings['hs'] = { '<cmd>Gitsigns stage_hunk<CR>', "stage hunk" }
lvim.builtin.which_key.mappings['hr'] = { '<cmd>Gitsigns reset_hunk<CR>', "reset hunk" }
lvim.builtin.which_key.mappings['hS'] = { '<cmd>Gitsigns stage_buffer<CR>', "stage buffer" }
lvim.builtin.which_key.mappings['hu'] = { '<cmd>Gitsigns undo_stage_hunk<CR>', "undo stage hunk" }
lvim.builtin.which_key.mappings['hR'] = { '<cmd>Gitsigns reset_buffer<CR>', "reset buffer" }
lvim.builtin.which_key.mappings['hp'] = { '<cmd>Gitsigns preview_hunk<CR>', "preview hunk" }
lvim.builtin.which_key.mappings['hb'] = { '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', "blame line" }
lvim.builtin.which_key.mappings['tb'] = { '<cmd>Gitsigns toggle_current_line_blame<CR>', "toggle current line blame" }
lvim.builtin.which_key.mappings['hd'] = { '<cmd>Gitsigns diffthis<CR>', "diff this" }
lvim.builtin.which_key.mappings['hD'] = { '<cmd>lua require"gitsigns".diffthis("~")<CR>', "diff HEAD" }

lvim.builtin.bufferline.options.numbers = "ordinal"
lvim.builtin.bufferline.options.diagnostics = false

lvim.builtin.which_key.mappings["f"] = { "", "file related" }
lvim.builtin.which_key.mappings["c"] = { "", "code related" }
lvim.builtin.which_key.mappings["ca"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code action" }
lvim.builtin.which_key.mappings["cd"] = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", 'code diagnostic' }
lvim.builtin.which_key.mappings["cf"] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", 'code format' }
lvim.builtin.which_key.mappings["cl"] = { "<cmd>lua vim.lsp.codelens.run()<cr>" }

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "startify"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.cmp.completion.autocomplete = false

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
  "hcl"
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.hcl = {
  filetype = "hcl", "terraform",
}

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" }, extra_args = { "-l 120" } },
  { command = "isort", filetypes = { "python" } },
  { command = "gofumpt", filetypes = { "go" } },
  { command = "goimports", filetypes = { "go" } },
  { command = "golines", filetypes = { "go" }, extra_args = { "-m 120" } },
  { command = "sql_formatter", filetypes = { "sql" } },
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
  { command = "flake8", filetypes = { "python" },
    extra_args = { "--max-line-length=120", "--ignore=F401,E121,E501,F403,W503", "--max-complexity=15" },
  },
  { command = "golangci-lint", filetypes = { "go" } },
  --[[ { ]]
  --[[   command = "eslint_d", ]]
  --[[   filetypes = { "javascript", "typescript", "vue", "typescriptreact" }, ]]
  --[[ }, ]]
}
-- Additional Plugins
lvim.plugins = {
  {
    "p00f/nvim-ts-rainbow",
  },
  {
    'sQVe/sort.nvim',
  },
  {
    "ms-jpq/coq_nvim", branch = "coq",
    config = function()
    end
  },
  {
    "ms-jpq/coq.artifacts", branch = "artifacts"
  },
  { "ms-jpq/coq.thirdparty", branch = "3p" },
  { "nacro90/numb.nvim",
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
    ft = { "fugitive" },
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "GRead",
      "GWrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
  },
  { 'TimUntersberger/neogit' },
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
      require("colorizer").setup({ 'vim'; 'css'; 'html'; 'vue'; 'lua'; 'markdown', "yml" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end
  },
  { "danymat/neogen",
    config = function()
      require('neogen').setup {}
    end
  },
  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 121; -- Width of the floating window
        height = 40; -- Height of the floating window
        default_mappings = true; -- Bind default mappings
        debug = false; -- Print debug information
        opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil; -- A function taking two arguments, a buffer and a window to be ran as a hook.
        resizing_mappings = true;
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
        -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
        -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
        -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
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
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.constant.alias.bool, -- boolean value (true <-> false)
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
          augend.constant.new {
            elements = { "True", "False" },
            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
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
    "lukas-reineke/indent-blankline.nvim",
    setup = function()
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
          "IndentBlanklineIndent6",
        }
      }
      vim.g.indentLine_enabled = 0
      vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard", "vista_kind", "lua", "Trouble",
        "NvimTree" }
      vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_current_context = true
      vim.g.indent_blankline_show_first_indent_level = false
      vim.g.indent_blankline_use_treesitter = true
      vim.g.indent_blankline_filetype = { 'python', "sh", 'go' }
      vim.g.indent_blankline_char_list = { '|', '¦', '¦' }
      vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent2 guifg=#C678DD gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
      vim.g.indent_blankline_context_patterns = {
        "class",
        "return",
        "function",
        "method",
        "^if",
        "^while",
        "jsx_element",
        "^for",
        "^object",
        "^table",
        "block",
        "arguments",
        "if_statement",
        "else_clause",
        "jsx_element",
        "jsx_self_closing_element",
        "try_statement",
        "catch_clause",
        "import_statement",
        "operation_type",
      }
    end
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects', lock = true },
  {
    "romgrk/nvim-treesitter-context",
    ft = { "sh", "go", "python", "vue", 'javascript', 'typescript' },
    config = function()
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },
  { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', lock = true, ft = "markdown" },
  { 'mzlogin/vim-markdown-toc', ft = 'markdown', lock = true },
  { 'tpope/vim-markdown', ft = 'markdown', lock = true },
  { 'hotoo/pangu.vim', ft = { 'markdown', 'vimwiki', 'text' }, lock = true },
  { 'mtdl9/vim-log-highlighting', lock = true },
  { 'kevinhwang91/nvim-hlslens',
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
  { 'michaelb/sniprun', run = 'bash ./install.sh' },
  { 'liuchengxu/vista.vim',
    cmd = 'Vista',
    config = function()
      vim.g.vista_default_executive = 'nvim_lsp'
    end
  },
  { "simrat39/symbols-outline.nvim" },
  { "Shatur/neovim-session-manager",
    config = function()
      require("session_manager").setup(
        {
          sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
          path_replacer = '__', -- The character to which the path separator will be replaced for session files.
          colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
          autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
          autosave_last_session = true, -- Automatically save last session on exit and on session switch.
          autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
          autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
            'gitcommit',
          },
          autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
          max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
        }
      )
      vim.cmd([[
        augroup _open_nvim_tree
        autocmd! * <buffer>
        autocmd SessionLoadPost * silent! lua require("nvim-tree").toggle(false, true)
        augroup end
        ]])
    end
  },
  { "tami5/sqlite.lua" },
  { 'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("neoclip")
      require("telescope").load_extension("frecency")
      require('telescope').load_extension("macroscope")
      -- require("telescope").load_extension("dap")
    end
  },
  { 'mbbill/undotree', cmd = 'UndotreeToggle' },
  {
    "nvim-telescope/telescope-frecency.nvim",
    requires = { "tami5/sqlite.lua" },
  },
  { "windwp/nvim-spectre" },
  -- { "ray-x/lsp_signature.nvim", config = function()
  --   require("lsp_signature").setup(
  --     {
  --       debug = false, -- set to true to enable debug logging
  --       log_path = "debug_log_file_path", -- debug log path
  --       verbose = false, -- show debug line number
  --       bind = true, -- This is mandatory, otherwise border config won't get registered.
  --       -- If you want to hook lspsaga or other signature handler, pls set to false
  --       doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
  --       -- set to 0 if you DO NOT want any API comments be shown
  --       -- This setting only take effect in insert mode, it does not affect signature help in normal
  --       -- mode, 10 by default
  --       floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
  --       floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  --       -- will set to true when fully tested, set to false will use whichever side has more space
  --       -- this setting will be helpful if you do not want the PUM and floating win overlap
  --       fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
  --       hint_enable = true, -- virtual hint enable
  --       hint_prefix = "🐼 ", -- Panda for parameter
  --       hint_scheme = "Comment",
  --       use_lspsaga = true, -- set to true if you want to use lspsaga popup
  --       hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  --       max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
  --       -- to view the hiding contents
  --       max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  --       handler_opts = {
  --         border = "rounded" -- double, rounded, single, shadow, none
  --       },

  --       always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  --       auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  --       extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  --       zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  --       padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc

  --       transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  --       shadow_blend = 36, -- if you using shadow as border use this set the opacity
  --       shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  --       timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  --       toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
  --     }
  --   )
  -- end
  -- },
  { "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup({
        mapping = { "jk", "jj" }, -- a table with mappings to use
        timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
        clear_empty_lines = false, -- clear line after escaping if there is only whitespace
        keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
      })
    end },
  {
    "folke/styler.nvim",
    config = function()
      require("styler").setup({
        themes = {
          markdown = { colorscheme = "monokai" },
          help = { colorscheme = "monokai" },
        },
      })
    end,
  },
  { "hzchirs/vim-material", lock = true },
  { 'projekt0n/github-nvim-theme', lock = true },
  { "EdenEast/nightfox.nvim" },
  { 'phanviet/vim-monokai-pro', lock = true },
  { 'mhartington/oceanic-next', lock = true },
  { 'patstockwell/vim-monokai-tasty', lock = true },
  { 'KeitaNakamura/neodark.vim', lock = true },
  { 'catppuccin/nvim' },
  { "sainnhe/sonokai", lock = true },
  { "sickill/vim-monokai" },
  { "AckslD/nvim-neoclip.lua", as = 'neoclip',
    config = function()
      require('neoclip').setup(
        {
          history = 1000,
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
  { 'uga-rosa/translate.nvim' },
}
