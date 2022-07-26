set cursorline
set undodir=~/.vim/undo-dir
set undofile
set history=1000
set foldlevel=1
set foldmethod=syntax
set foldnestmax=100
set nofoldenable

if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

let g:fzf_layout = { 'down': '~80%'}
let g:far#enable_undo=1

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" UI Settings
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'rcarriga/nvim-notify'
Plug 'stevearc/dressing.nvim'

Plug 'folke/which-key.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'RRethy/vim-illuminate'
Plug 'glepnir/lspsaga.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'ray-x/lsp_signature.nvim'

" Plug 'liuchengxu/vista.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'sindrets/diffview.nvim'

" Version Control
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'

" Themes
"Plug 'morhetz/gruvbox'
"Plug 'joshdick/onedark.vim'
Plug 'Mofiqul/vscode.nvim'
Plug 'doums/darcula'
Plug 'lukas-reineke/indent-blankline.nvim'

" Project manage
"Plug 'rmagatti/auto-session'
"Plug 'rmagatti/session-lens'
" Plug 'nvim-pack/nvim-spectre'
Plug 'folke/trouble.nvim'
Plug 'brooth/far.vim'
Plug 'ahmedkhalf/project.nvim'
" Nvim Treesitter configurations and abstraction layer & highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Search
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
" Plug 'mileszs/ack.vim'

" Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'jiangmiao/auto-pairs'
" Plug 'kien/rainbow_parentheses.vim'
Plug 'mattn/emmet-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'mhinz/vim-startify'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'psliwka/vim-smoothie'
Plug 'scrooloose/nerdcommenter'

" Performance issue in monorepo
" Plug 'nvim-lualine/lualine.nvim'

"Status line
Plug 'feline-nvim/feline.nvim'

" Plug 'dense-analysis/ale'
" Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'wfxr/minimap.vim'
Plug 'petertriho/nvim-scrollbar'
            
" Code manage
Plug 'stevearc/aerial.nvim' " A code outline window for skimming and quick navigation
Plug 'sheerun/vim-polyglot'

" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" Initialize plugin system
call plug#end()


lua << EOF
require "init"
EOF

if has_key(plugs, "coc.nvim")
    source $HOME/.config/nvim/settings/coc.vim
endif
source $HOME/.config/nvim/settings/theme.vim

inoremap jk <ESC>

let g:minimap_width = 10
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1


" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

set relativenumber

" Ignore case when searching
set ignorecase

set smarttab
set cindent
set tabstop=2
set shiftwidth=2
" always uses spaces instead of tab characters
set expandtab

set spell spelllang=en_us

set mouse=a

" Indent and whitespace
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent

set nocompatible

" When searching try to be smart about cases 
set smartcase

set clipboard+=unnamedplus

set termguicolors

syntax enable

" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:go_fmt()
  cexpr system('gofmt -e -w ' . expand('%'))
  edit!
endfunction

syntax sync minlines=256

command! -bang -nargs=* Rg call fzf#vim#grep("rg -M 100 --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({}), <bang>0)
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--reverse'}), <bang>0)
command! -nargs=* AgQ call fzf#vim#ag(<q-args>, {'down': '40%', 'options': '-q '.shellescape(<q-args>.' ')})
command! -bang -nargs=* AgWords call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--reverse --delimiter : --nth 4..'}), <bang>0)

command! -bang -nargs=* RgFiles
command! -bang -nargs=* Gofmt call system('gofmt -e -w ' . expand('%'))

nnoremap <C-p> :lua require'fzf-lua'.git_files({ prompt="LS> ", cwd="~/<folder>" })<Cr>
nnoremap <C-f> :lua require'fzf-lua'.live_grep({ cmd = "git grep --line-number --column --color=always" })<Cr>
nnoremap <leader>h :WhichKey<Cr>
