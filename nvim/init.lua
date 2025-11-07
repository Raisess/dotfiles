-- Plugin manager setup with 'packer.nvim' (recommended for Lua)
-- If you want to stick with vim-plug, you can use vim.cmd([[Plug ...]])
-- But packer.nvim is the native Lua plugin manager widely used

-- Install packer.nvim if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      "git", "clone", "--depth", "1",
      "https://github.com/wbthomason/packer.nvim", install_path
    })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Plugins
require("packer").startup(function(use)
  -- fuzzy finder
  use { "junegunn/fzf", run = function() vim.fn["fzf#install"]() end }
  use "junegunn/fzf.vim"

  -- colorschemes
  use "pantharshit00/vim-prisma"
  use "morhetz/gruvbox"
  use "nvim-treesitter/nvim-treesitter"

  -- lsp
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'

  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- Options
local opt = vim.opt
opt.mouse = "a"
opt.signcolumn = "yes"
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.number = true
opt.cmdheight = 1
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smarttab = true
opt.cindent = true
opt.autoindent = true
opt.autoread = true
opt.smartindent = true
opt.background = "dark"
opt.errorbells = false
opt.updatetime = 500
opt.laststatus = 2
opt.guioptions = opt.guioptions - "L"
opt.guicursor = ""
opt.termguicolors = true
opt.hidden = true
opt.wrap = false
opt.formatoptions = "l"
opt.textwidth = 0
opt.wrapmargin = 0
opt.shortmess:append("c")
opt.cursorcolumn = false
opt.cursorline = false
opt.relativenumber = false
opt.colorcolumn = "80"
vim.cmd("syntax sync minlines=256")

-- Filetype detection for *.ejs
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.ejs",
  callback = function() vim.bo.filetype = "html" end,
})

-- Statusline setup
vim.o.statusline = " >>> [%{strlen(&ft)?&ft:'none'}] FILE: %f                                  %m%=%-14(%l,%c%V%)%<%P "

-- Global vars (equivalent to let g:)
vim.g.netrw_list_hide = "__pycache__/"
vim.g.python_recommended_style = 0
vim.g.rust_recommended_style = 0
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.fzf_preview_window = {}

vim.g.gruvbox_contrast_dark = "hard"
vim.g.gruvbox_invert_selection = "0"
vim.cmd.colorscheme("gruvbox")

if not vim.fn.has("gui_running") then
  vim.o.t_Co = 256
end

-- Commands
vim.api.nvim_create_user_command("Prettier", function()
  vim.cmd("silent !prettier --write %:h/%:t:r.%:e")
end, {})

vim.api.nvim_create_user_command("Lint", function()
  vim.cmd("silent !eslint --fix %:h/%:t:r.%:e")
end, {})

-- Keymaps
local keymap_opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-h>", ":nohl<CR>", keymap_opts)
vim.keymap.set("n", "<C-t>", ":tabnew<CR>", keymap_opts)
vim.keymap.set("n", "gb", ":tabprevious<CR>", keymap_opts)
vim.keymap.set("n", "<C-a>", ":Prettier<CR>", keymap_opts)
vim.keymap.set("n", "<C-b>", ":Explore<CR>", keymap_opts)
vim.keymap.set("n", "<C-f>", ":Vexplore<CR>", keymap_opts)
vim.keymap.set("n", "<C-n>", ":vsplit term://zsh<CR>:set nonu<CR>", keymap_opts)

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", keymap_opts)

vim.keymap.set("n", "<C-p>", ":GFiles<CR>", keymap_opts)

-- Auto close brackets
vim.keymap.set("i", '"', '""<Left>', { noremap = true })
vim.keymap.set("i", "'", "''<Left>", { noremap = true })
vim.keymap.set("i", "(", "()<Left>", { noremap = true })
vim.keymap.set("i", "[", "[]<Left>", { noremap = true })
vim.keymap.set("i", "{", "{}<Left>", { noremap = true })
vim.keymap.set("i", "{<CR>", "{<CR>}<ESC>O", { noremap = true })
vim.keymap.set("i", "{;<CR>", "{<CR>};<ESC>O", { noremap = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set("n", "gh", vim.lsp.buf.hover, { noremap = true, silent = true })
vim.keymap.set("n", "m", vim.diagnostic.goto_next, { noremap = true, silent = true })

-- Completion options
vim.o.completeopt = "menu,menuone,noselect"

require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  }
})

require("mason").setup()

local cmp = require("cmp")

cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        look = "[Dict]",
        buffer = "[Buffer]",
      })[entry.source.name]

      return vim_item
    end
  },
  mapping = {
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  },
  sources = {
    { name = "buffer" },
    { name = "nvim_lsp" },
  }
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_create_autocmd("FileType", {
  pattern = "typescript",
  callback = function()
    vim.lsp.enable("ts_ls")
    vim.lsp.config("ts_ls", {
      cmd = { "typescript-language-server" },
      filetypes = { "typescript", "javascript" },
      capabilities = capabilities,
    })
    vim.lsp.start("ts_ls")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.lsp.enable("jedi_language_server")
    vim.lsp.config("jedi_language_server", {
      cmd = { "jedi-language-server" },
      filetypes = { "python" },
      capabilities = capabilities,
    })
    vim.lsp.start("jedi_language_server")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.lsp.enable("rust_analyzer")
    vim.lsp.config("rust_analyzer", {
      cmd = { "rust-analyzer" },
      filetypes = { "rust" },
      capabilities = capabilities,
    })
    vim.lsp.start("rust_analyzer")
  end,
})

for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
  local default_diagnostic_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, result, context, config)
    if err ~= nil and err.code == -32802 then
        return
    end
    return default_diagnostic_handler(err, result, context, config)
  end
end

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
