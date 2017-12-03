if has("vim_starting")
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand("~/.vim/bundle/"))

NeoBundleFetch "Shougo/neobundle.vim"

NeoBundle "Shougo/neocomplete.vim"
NeoBundle "Shougo/vimproc.vim", { "build": { "linux": "make" } }
NeoBundle "Yggdroot/indentLine"
NeoBundle "cohama/vim-hier"
NeoBundle "dannyob/quickfixstatus"
NeoBundle "eagletmt/ghcmod-vim"
NeoBundle "elzr/vim-json"
NeoBundle "itchyny/lightline.vim"
NeoBundle "jistr/vim-nerdtree-tabs"
NeoBundle "osyo-manga/vim-watchdogs"
NeoBundle "osyo-manga/shabadou.vim"
NeoBundle "scrooloose/nerdtree"
NeoBundle "thinca/vim-quickrun"

call neobundle#end()

filetype plugin indent on

NeoBundleCheck


" lightline.vim
let g:lightline = { "colorscheme": "solarized" }

" vim-watchdogs
let g:watchdogs_check_BufWritePost_enable = 1

let g:watchdogs_check_BufWritePost_enables = { "haskell": 0 }

let g:watchdogs_check_BufWritePost_enable_on_wq = 0

let g:quickrun_config = {
\   "_": {
\       "outputter": "quickfix",
\       "runner":    "vimproc",
\
\       "runner/vimproc/updatetime": 10
\   },
\
\   "cpp/watchdogs_checker"   : { "type": "watchdogs_checker/clang++" },
\   "d/watchdogs_checker"     : { "type": "watchdogs_checker/dmd" },
\   "python/watchdogs_checker": { "type": "watchdogs_checker/flake8" },
\
\   "watchdogs_checker/clang++": { "cmdopt": "-Wall -Wextra -std=c++1z" },
\   "watchdogs_checker/dmd"    : { "cmdopt": "-wi -o- `~/dubimport -o`" }
\ }

call watchdogs#setup(g:quickrun_config)

let s:hook = { "name": "clear_quickfix", "kind": "hook" }

function! s:hook.on_normalized(session, context)
    call setqflist([])
endfunction

call quickrun#module#register(s:hook, 1)

unlet s:hook

" ghcmod-vim
autocmd BufWritePost *.hs GhcModCheckAndLintAsync

" vim-json
let g:vim_json_syntax_conceal = 0

" nerdtree
let g:nerdtree_tabs_open_on_console_startup = 1

let g:NERDTreeMinimalUI  = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize    = 70

let g:NERDTreeWinPos = "right"


syntax on

set autoindent
set cursorline
set colorcolumn=120
set encoding=utf-8
set expandtab
set fileencodings=utf-8
set fileformats=unix
set laststatus=2
set list
set listchars=tab:»_,trail:_,extends:»,precedes:«
set nobackup
set number
set relativenumber
set shiftwidth=4
set showtabline=2
set tabstop=4

noremap <C-Left>  <C-W>h
noremap <C-Right> <C-W>l
noremap <C-Up>    <C-W>k
noremap <C-Down>  <C-W>j
noremap <S-Left>  :tabprevious <CR>
noremap <S-Right> :tabnext <CR>
noremap c         :tabclose <CR>
noremap t         :tabnew <CR>
noremap r         <C-R>
