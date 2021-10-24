
-- general
-- lvim
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"

--nvim
vim.opt.colorcolumn = "80"
vim.opt.spelllang = "en"
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.foldlevelstart=10
vim.opt.showbreak="<--"
vim.opt.linebreak = true
vim.opt.wrap = true
vim.opt.foldenable = true
vim.opt.foldmethod= "indent"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<A-Left>"] = ":bprev<cr>"
lvim.keys.normal_mode["<A-Right>"] = ":bnext<cr>"
lvim.keys.normal_mode["<A-w>"] = ":BufferClose<cr>"

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.hide_dotfiles = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "java",
  "yaml",
}

-- lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Additional Plugins
lvim.plugins = {
    {
      "folke/trouble.nvim",
      cmd = "TroubleToggle",
    },
  { "sindrets/diffview.nvim" },
  {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufRead",
  setup = function()
    vim.g.indentLine_enabled = 1
    vim.g.indent_blankline_char = "▏"
    vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
    vim.g.indent_blankline_buftype_exclude = {"terminal"}
    vim.g.indent_blankline_show_trailing_blankline_indent = false
    vim.g.indent_blankline_show_first_indent_level = false
  end
},
  {
  "iamcco/markdown-preview.nvim",
  run = "cd app && npm install",
  ft = "markdown",
  config = function()
    vim.g.mkdp_auto_start = 1
  end,
  },
  {
    "tpope/vim-surround",
    keys = {"c", "d", "y"}
  },
  {
  "windwp/nvim-spectre",
  event = "BufRead",
  config = function()
    require("spectre").setup()
  end,
  },
  {
  "f-person/git-blame.nvim",
  event = "BufRead",
  config = function()
    vim.cmd "highlight default link gitblame SpecialComment"
    vim.g.gitblame_enabled = 0
  end,
  },
  {
  "nvim-treesitter/playground",
  event = "BufRead",
  },
  {
  "rmagatti/goto-preview",
  config = function()
  require('goto-preview').setup {
        width = 120;
        height = 25;
        default_mappings = true;
        debug = false;
        opacity = nil;
        post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
    }
    end
  },
  {
    "metakirby5/codi.vim",
    cmd = "Codi",
  },
  {
  "folke/todo-comments.nvim",
  event = "BufRead",
  config = function()
    require("todo-comments").setup()
  end,
  },
}

