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
Plug 'williamboman/nvim-lsp-installer'

" cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

call plug#end()

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

" LSP
noremap <silent> <C-k> :lua vim.lsp.diagnostic.goto_prev()<CR>
noremap <silent> <C-j> :lua vim.lsp.diagnostic.goto_next()<CR>

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
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
  }
}

local cmp = require('cmp')

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
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
  }
})

local nvim_lsp = require('lspconfig')
local lsp_installer = require('nvim-lsp-installer')

local function on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

lsp_installer.on_server_ready(function(server)
    server:setup({
      capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
      on_attach = on_attach,
    })
end)
EOF
