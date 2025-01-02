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



lua << EOF
    require "init"
EOF

"source $HOME/.config/nvim/settings/coc.vim

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
nnoremap <C-f> :lua require'fzf-lua'.live_grep({ cmd = "git grep --line-number --column --color=always", cwd="~/<folder>"  })<Cr>
nnoremap <C-a> :Telescope ast_grep<Cr>

nnoremap <leader>h :WhichKey<Cr>

