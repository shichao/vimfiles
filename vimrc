" General settings
set nocompatible                " choose no compatibility with legacy vi
syntax enable
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
set laststatus=2                " Always show the statusline
set hidden                      " Maintain scroll position (don't close buffer)

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=4 shiftwidth=4      " a tab is two spaces (or set this to 4)
set smarttab
"set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" Misc shortcuts
let mapleader =","


"" Pathogen
call pathogen#infect()

"" Color scheme & font
if has("gui_running")
  set guioptions-=T
  set t_Co=256
  colorscheme molokai

  " for mac
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h14
  endif
  " for windows
  if has("gui_win32") || has("gui_win32s")
    set guifont=Consolas:h12
    " CTRL-X and SHIFT-Del are Cut
    vnoremap <C-X> "+x
    vnoremap <S-Del> "+x

    " CTRL-C and CTRL-Insert are Copy
    vnoremap <C-C> "+y
    vnoremap <C-Insert> "+y

    " CTRL-V and SHIFT-Insert are Paste
    map <C-V>   	"+gP
    map <S-Insert>  	"+gP
    cmap <C-V>  	<C-R>+
    cmap <S-Insert> 	<C-R>+ 
  endif
else
  colorscheme zellner
  set background=dark
endif

"" Line numbering, cursor
set nu                            " Show relative line numbers.
set ruler                         " Show cursor position.
set so=7                          " Set 7 lines to the curors - when moving vertical..

"" NERDTree
function! ShowFileInNERDTree()
  if exists("t:NERDTreeBufName")
    NERDTreeFind
  else
    NERDTree
    wincmd l
    NERDTreeFind
  endif
endfunction
map <leader>d :call ShowFileInNERDTree()<cr>

"" Yankring
let g:yankring_history_file = '.yankring_history'

"" Pane switching shortcuts
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>w :vsplit<cr>  " Split pane vertically
nnoremap <leader>h :split<cr>   " Split pane horizon
nnoremap <leader>q :q<cr>       " Close current window

"" Wild stuff
set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set wildignore+=vendor,log,tmp,*.swp,.git,gems,.bundle,Gemfile.lock,.gem,.rvmrc,.gitignore,.DS_Store

" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

"" Trailing whitespace
"highlight ExtraWhitespace ctermbg=red guibg=red
"match ExtraWhitespace /\s\+$/

"" Autocmd

if has("gui_mac") || has("gui_macvim")
	autocmd! bufwritepost .vimrc :source ~/.vimrc      " for mac macvim 
else
	autocmd! bufwritepost _vimrc :source $VIM/_vimrc 	" for windows gvim 
endif

" Statusline
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c  
function! CurDir()
  let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
  return curdir
endfunction

function! HasPaste()
  if &paste
      return 'PASTE MODE  '
  else
      return ''
  endif
endfunction
