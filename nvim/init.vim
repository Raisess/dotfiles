" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" fuzzy
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" colors
Plug 'pantharshit00/vim-prisma'
Plug 'morhetz/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'

call plug#end()

set mouse=a
set signcolumn=yes
set noswapfile
set nobackup
set nowritebackup
set number
set cmdheight=1
set smarttab
set cindent
set autoindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set background=dark
set noerrorbells
set updatetime=500
set laststatus=2
set guioptions-=L
set guicursor=
set termguicolors
set hidden
set nowrap
set formatoptions=l
set textwidth=0 wrapmargin=0
set shortmess+=c
set nocursorcolumn
set nocursorline
set norelativenumber
syntax sync minlines=256

set statusline=
set statusline+=\ Vimmer\ \                          " fun name
set statusline+=%f\                                  " filename
set statusline+=\[%{strlen(&ft)?&ft:'none'}]\        " file type
set statusline+=%m                                   " modified flag
set statusline+=%=                                   " right align remainder
set statusline+=%-14(%l,%c%V%)                       " line, character
set statusline+=%<%P\                                " file position

let g:netrw_banner=0
let g:netrw_liststyle=3
let g:fzf_preview_window=[]

let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'
colorscheme gruvbox

if !has('gui_running')
  set t_Co=256
endif

"Formatters
command! -nargs=0 Prettier :silent exec "!prettier --write %:h/%:t:r.%:e"
command! -nargs=0 Lint :silent exec "!eslint --fix %:h/%:t:r.%:e"

" Custom bindings
noremap <silent> <C-h> :nohl<CR>
noremap <silent> <C-t> :tabnew<CR>
noremap <silent> gb :tabprevious<CR>
noremap <silent> <C-a> :Prettier<CR>
noremap <silent> <C-b> :Explore<CR>
noremap <silent> <C-f> :Vexplore<CR>

" FZF
noremap <silent> <C-p> :GFiles<CR>
noremap <silent> <C-o> :W<CR>

" LSP
"noremap <silent> <C-k> :lua vim.lsp.diagnostic.goto_prev()<CR>
"noremap <silent> <C-j> :lua vim.lsp.diagnostic.goto_next()<CR>

" Auto close brackets
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

set completeopt=menu,menuone,noselect

lua <<EOF
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  }
})

require("mason").setup()
require("mason-lspconfig").setup()

local cmp = require("cmp")
local cmp_lsp = require("cmp_nvim_lsp")
local nvim_lsp = require("lspconfig")
local util = require("lspconfig.util")

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

local function on_attach(client, bufnr)
  local opts = {
    noremap = true,
    silent = true,
    buffer = bufnr
  }

  vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.keymap.set("n", "gh", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
end

local default_capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp["clangd"].setup({
  capabilities = default_capabilities,
  on_attach = on_attach,
  cmd = { "clangd", "-j=1", "--background-index", "--malloc-trim" },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
EOF
