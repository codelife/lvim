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
lvim.colorscheme = "onedarker"
lvim.builtin.lualine.options.theme = "rose-pine"
lvim.transparent_window = true
lvim.lsp.diagnostics.virtual_text = false
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 120
lvim.builtin.telescope.defaults.layout_config.vertical.mirror = false
lvim.builtin.telescope.defaults.layout_config.width = 0.85
vim.opt.splitbelow = false
vim.opt.foldmethod = "expr" -- fold with nvim_treesitter
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false -- no fold to be applied when open a file
vim.opt.foldlevel = 99
vim.opt.guifont = ""

vim.api.nvim_create_autocmd("ColorScheme", { pattern = { "*" }, command = "lua require('user.lualine')" })
vim.api.nvim_create_autocmd("ColorScheme", { pattern = { "*" }, command = "lua require('user.bufferline')" })

vim.cmd([[
  augroup _fold_bug_solution  " https://github.com/nvim-telescope/telescope.nvim/issues/559
    autocmd!
    autocmd BufRead * autocmd BufWinEnter * ++once normal! zx
  augroup end
]])

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

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
  add          = { hl = 'GitSignsAdd', text = '+', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
  change       = { hl = 'GitSignsChange', text = '*', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
  delete       = { hl = 'GitSignsDelete', text = '-', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
  topdelete    = { hl = 'GitSignsDelete', text = '-', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
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
vim.api.nvim_set_keymap('n', '//', "<cmd>nohlsearch<cr>", {})
vim.api.nvim_set_keymap('n', '<c-p>', "<cmd>BufferLineCyclePrev<cr>", {})
vim.api.nvim_set_keymap('n', '<c-n>', "<cmd>BufferLineCycleNext<cr>", {})

vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('n', 'w', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>", {})
vim.api.nvim_set_keymap('n', 'b', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<cr>", {})
vim.api.nvim_set_keymap('v', 'w', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>", {})
vim.api.nvim_set_keymap('v', 'b', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<cr>", {})
vim.api.nvim_set_keymap('n', 'g;', "<cmd>lua require'hop'.hint_words({ current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
vim.api.nvim_set_keymap('v', 'r', '<Plug>SnipRun', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>co', '<Plug>SnipRunOperator', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>cr', '<Plug>SnipRun', { silent = true })

lvim.builtin.which_key.mappings["0"] = { "<cmd>BufferLineTogglePin <CR>", "buffer pin" }
lvim.builtin.which_key.mappings["1"] = { "<cmd>BufferLineGoToBuffer 1<CR>", "Explorer" }
lvim.builtin.which_key.mappings["2"] = { "<cmd>BufferLineGoToBuffer 2<CR>", "Explorer" }
lvim.builtin.which_key.mappings["3"] = { "<cmd>BufferLineGoToBuffer 3<CR>", "Explorer" }
lvim.builtin.which_key.mappings["4"] = { "<cmd>BufferLineGoToBuffer 4<CR>", "Explorer" }
lvim.builtin.which_key.mappings["5"] = { "<cmd>BufferLineGoToBuffer 5<CR>", "Explorer" }
lvim.builtin.which_key.mappings["6"] = { "<cmd>BufferLineGoToBuffer 6<CR>", "Explorer" }
lvim.builtin.which_key.mappings["7"] = { "<cmd>BufferLineGoToBuffer 7<CR>", "Explorer" }
lvim.builtin.which_key.mappings["8"] = { "<cmd>BufferLineGoToBuffer 8<CR>", "Explorer" }
lvim.builtin.which_key.mappings["9"] = { "<cmd>BufferLineGoToBuffer 9<CR>", "Explorer" }
lvim.builtin.which_key.mappings["n"] = { "<cmd>NvimTreeToggle<CR>", "nvim-tree" }
lvim.builtin.which_key.mappings["e"] = { "<cmd>Telescope oldfiles<cr>", "Recent Files" }
lvim.builtin.which_key.mappings["u"] = { "<cmd>UndotreeToggle<cr>", "Undo Tree" }
lvim.builtin.which_key.mappings["q"] = { "<cmd>close<CR>", 'quit' }
lvim.builtin.which_key.mappings["S"] = { "<cmd>lua require('spectre').open()<CR>", 'search' }
lvim.builtin.which_key.mappings["sw"] = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", 'search current word' }
lvim.builtin.which_key.mappings["sg"] = { "<cmd>lua require('spectre').open_file_search()<CR>", 'search in current file' }
lvim.builtin.which_key.mappings["dd"] = { "<Cmd>BufferKill<CR>", 'Buffer kill' }
lvim.builtin.which_key.mappings["dg"] = { "<Cmd>Neogen<CR>", 'gen doc' }
lvim.builtin.which_key.mappings["ba"] = { "<cmd>BufferLineSortByDirectory<cr>", "Buffer sort directory" }
lvim.builtin.which_key.mappings["bc"] = { "<cmd>BufferLinePickClose<cr>", "Buffer pick close" }
lvim.builtin.which_key.mappings["bs"] = { "<cmd>BufferLineSortByExtension<cr>", "Sort buffer ext" }
lvim.builtin.which_key.mappings["lpp"] = { "<cmd>Telescope projects<cr>", "Projects" }
lvim.builtin.which_key.mappings["ss"] = { "<cmd>SessionManager save_current_session<cr>", "Save current session" }
lvim.builtin.which_key.mappings["sa"] = { "<cmd>SessionManager load_session<cr>", "Show all session" }
lvim.builtin.which_key.mappings["sl"] = { "<cmd>SessionManager load_last_session<cr>", "Load last session" }
lvim.builtin.which_key.mappings["sc"] = { "<cmd>SessionManager load_current_dir_session<cr>", "Restore last session for CurrentDir" }
lvim.builtin.which_key.mappings["fd"] = { "<cmd>RnvimrToggle<cr>", 'ranger' }
lvim.builtin.which_key.mappings["ff"] = { "<cmd>Telescope find_files<cr>", "Find file" }
lvim.builtin.which_key.mappings["fg"] = { "<cmd>Telescope live_grep<cr>", "Live grep" }
lvim.builtin.which_key.mappings["lc"] = { "<cmd>lua require'telescope.builtin'.command_history{}<cr>", "Command history" }
lvim.builtin.which_key.mappings["la"] = { "<cmd>Telescope commands<cr>", "All commands" }
lvim.builtin.which_key.mappings["lt"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace symbol" }
lvim.builtin.which_key.mappings["lf"] = { "<cmd>Telescope search_history<cr>", "Search history" }
lvim.builtin.which_key.mappings["ls"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbol" }
lvim.builtin.which_key.mappings["lr"] = { "<cmd>lua require'telescope.builtin'.registers{}<cr>, ", "registers" }
lvim.builtin.which_key.mappings["lh"] = { "<cmd>HopLine<cr>", "hop line" }
lvim.builtin.which_key.mappings["ll"] = { "<cmd>NvimTreeFindFile<cr>", "locate file" }
lvim.builtin.which_key.mappings["lj"] = { "<cmd>lua require'telescope.builtin'.jumplist{}<cr>", "jumplist" }
lvim.builtin.which_key.mappings["lk"] = { "<cmd>lua require'telescope.builtin'.keymaps{}<cr>", "keymaps" }
lvim.builtin.which_key.mappings["i"] = { "<cmd>IndentBlanklineToggle<cr>", "blankline toggle" }
lvim.builtin.which_key.mappings["td"] = { "<cmd>TodoTelescope<cr>", "List Todo" }
lvim.builtin.which_key.mappings["tt"] = { "<cmd>Vista nvim_lsp<cr>", "Code Navigate" }
lvim.builtin.which_key.mappings["tl"] = { "<cmd>Twilight<cr>", "Code twilight" }
lvim.builtin.which_key.mappings["mp"] = { "<cmd>MarkdownPreview<cr>", "Markdown Preview " }
lvim.builtin.which_key.mappings["mg"] = { "<cmd>GenTocMarked<cr>", "Markdown GenTocMarked " }
lvim.builtin.which_key.mappings["mf"] = { "<cmd>PanguALL<cr>", "Text format" }

lvim.builtin.which_key.mappings["gd"] = { "<cmd>Gdiffsplit!<cr>", "git diff current file" }
lvim.builtin.which_key.mappings["gv"] = { "<cmd>DiffviewOpen<cr>", "git diff view" }
lvim.builtin.which_key.mappings["gq"] = { "<cmd>DiffviewClose<cr>", "git diffview close" }
lvim.builtin.which_key.mappings["gs"] = { "<cmd>Git<cr>", "git status" }
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

lvim.builtin.which_key.mappings["="] = { "<c-w>10+", "increase window size" }
lvim.builtin.which_key.mappings["-"] = { "<c-w>10-", "decrease window size" }
lvim.builtin.which_key.mappings["]"] = { "<c-w>10>", "increase window size" }
lvim.builtin.which_key.mappings["["] = { "<c-w>10<", "decrease window size" }

lvim.builtin.cmp.formatting.source_names.buffer = "[Buf]"
lvim.builtin.cmp.formatting.source_names.calc = "[Calc]"
lvim.builtin.cmp.formatting.source_names.cmp_tabnine = "[TabNine]"
lvim.builtin.cmp.formatting.source_names.cmp_tabnine = "[Copilot]"
lvim.builtin.cmp.formatting.source_names.emoji = "[Emoji]"
lvim.builtin.cmp.formatting.source_names.luasnip = "[Snip]"
lvim.builtin.cmp.formatting.source_names.nvim_lsp = "[Lsp]"
lvim.builtin.cmp.formatting.source_names.path = "[Path]"
lvim.builtin.cmp.formatting.source_names.vsnip = "[Snip]"

lvim.builtin.bufferline.options.numbers = "ordinal"
lvim.builtin.bufferline.options.diagnostics = false

lvim.builtin.which_key.mappings["f"] = { "", "file related" }
lvim.builtin.which_key.mappings["c"] = { "", "code related" }
lvim.builtin.which_key.mappings["ca"] = { "<cmd>lua require('lvim.core.telggcope').code_actions()<cr>", 'code action' }
lvim.builtin.which_key.mappings["cd"] = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", 'code diagnostic' }
lvim.builtin.which_key.mappings["cf"] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", 'code format' }
lvim.builtin.which_key.mappings["cl"] = { "<cmd>lua vim.lsp.codelens.run()<cr>" }

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "startify"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true



-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" }, extra_args = { "-l 140" } },
  { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "120" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact", "typescript", "json", "html", "yaml" },
  },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "eslint_d",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  }
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" },
    extra_args = { "--max-line-length=140", "--ignore=E121,E501,F403,W503", "--max-complexity=12" },
  },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "eslint_d",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "typescript", "vue" },
  },
}
-- Additional Plugins
lvim.plugins = {
  {
    "p00f/nvim-ts-rainbow",
  },
  { "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end
  },
  { "folke/tokyonight.nvim" },
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
    "folke/lsp-colors.nvim",
    event = "BufRead",
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ 'vim'; 'css'; 'html'; 'vue'; 'lua'; 'markdown' }, {
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
  {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
    event = "InsertEnter",
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
        height = 25; -- Height of the floating window
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
    "lukas-reineke/indent-blankline.nvim",
    setup = function()
      require("indent_blankline").setup {
        show_current_context = true,
        space_char_blankline = " ",
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
        }
      }
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard", "vista_kind" }
      vim.g.indent_blankline_buftype_exclude = { "terminal" }
      vim.g.indent_blankline_show_trailing_blankline_indent = true
      vim.g.indent_blankline_show_first_indent_level = false
      vim.g.indent_blankline_use_treesitter = true
      vim.g.indent_blankline_filetype = { 'python', "sh", 'go' }
      vim.g.indent_blankline_char_list = { '|', '¦', '┆' }
      vim.cmd([[
        hi rainbowcol1 guifg=#34495e
        hi rainbowcol2 guifg=#00FFFF
        hi rainbowcol3 guifg=#46A3FF
        hi rainbowcol4 guifg=#AAAAFF
        hi rainbowcol5 guifg=#FFB5B5
        hi rainbowcol7 guifg=#FFE66F
      ]])
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
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },
  { "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" }
    }
  },
  { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview', lock = true },
  { 'mzlogin/vim-markdown-toc', ft = 'markdown', lock = true },
  { 'tpope/vim-markdown', ft = 'markdown', lock = true },
  { 'hotoo/pangu.vim', ft = { 'markdown', 'vimwiki', 'text' }, lock = true },
  { 'mtdl9/vim-log-highlighting', lock = true },
  { 'kevinhwang91/nvim-hlslens' },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("user.todo-comment")
    end,
  },
  {
    'github/copilot.vim',
    ft = { "sh", "go", "python", "vue", 'javascript', 'typescript' },
  },
  {
    "hrsh7th/cmp-copilot",
    ft = { "sh", "go", "python", "vue", 'javascript', 'typescript' },
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
  { 'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("neoclip")
      -- require("telescope").load_extension("dap")
    end
  },
  { "windwp/nvim-spectre" },
  { "ray-x/lsp_signature.nvim" },
  { 'mbbill/undotree', cmd = 'UndotreeToggle' },
  { 'gregsexton/Atom', lock = true },
  { "hzchirs/vim-material", lock = true },
  { 'projekt0n/github-nvim-theme', lock = true },
  { 'phanviet/vim-monokai-pro', lock = true },
  { 'mhartington/oceanic-next', lock = true },
  { 'patstockwell/vim-monokai-tasty', lock = true },
  { 'joshdick/onedark.vim', lock = true },
  { 'KeitaNakamura/neodark.vim', lock = true },
  { 'morhetz/gruvbox', lock = true },
  { 'liuchengxu/space-vim-dark', lock = true },
  { 'ray-x/aurora' },
  { "sickill/vim-monokai", lock = true },
  { "kyoz/purify", lock = true },
  { "AckslD/nvim-neoclip.lua", as = 'neoclip',
    config = function()
      require('neoclip').setup()
    end
  },
  { "stevearc/dressing.nvim" },
  { 'danilo-augusto/vim-afterglow', lock = true },
  { "cseelus/vim-colors-lucid", lock = true },
  { "folke/twilight.nvim", config = function()
    require("twilight").setup {
      dimming = {
        alpha = 0.25, -- amount of dimming
        -- we try to get the foreground from the highlight groups or fallback color
        color = { "Normal", "#ffffff" },
        inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
      },
      context = 20, -- amount of lines we will try to show around the current line
      treesitter = true, -- use treesitter when available for the filetype
      -- treesitter is used to automatically expand the visible text,
      -- but you can further control the types of nodes that should always be fully expanded
      expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        "function",
        "method",
        "table",
        "if_statement",
      },
      exclude = {}, -- exclude these filetypes
    }
  end },
  { "ayu-theme/ayu-vim",
    lock = true,
    config = function()
      vim.cmd([[
      let ayucolor="mirage"  " for mirage/dark/light version of theme
    ]] )
    end },
  { 'rose-pine/neovim',
    as = 'rose-pine',
    tag = 'v1.*',
    -- config = function()
    --   vim.cmd('colorscheme rose-pine')
    -- end
  }
}
