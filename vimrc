" Kromaĵojn
if has("vim_starting")
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand("~/.vim/bundle/"))

NeoBundleFetch "Shougo/neobundle.vim"

NeoBundle "Shougo/neocomplete.vim"
NeoBundle "Shougo/unite.vim"
NeoBundle "Shougo/vimfiler"
NeoBundle "Shougo/vimproc.vim", { "build": { "linux": "make" } }
NeoBundle "Yggdroot/indentLine"
NeoBundle "eagletmt/ghcmod-vim"
NeoBundle "elzr/vim-json"
NeoBundle "itchyny/lightline.vim"
NeoBundle "jceb/vim-hier"
NeoBundle "osyo-manga/vim-watchdogs"
NeoBundle "osyo-manga/shabadou.vim"
NeoBundle "thinca/vim-quickrun"

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

" Koloro
syntax on

" Pozicio
set number
set cursorline
set colorcolumn=120

" Aperoj de spacetoj
set list
set listchars=tab:»_,trail:_,extends:»,precedes:«,nbsp:%

" Indento
set autoindent
set expandtab
set shiftwidth=4
set tabstop=4

" Manipuli dosierojn
set nobackup
set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix

" Informoj
set showtabline=2
set laststatus=2

" lightline.vim
let g:lightline = { "colorscheme": "solarized" }

" vim-quickrun
let g:quickrun_config = {
\   "_": {
\       "outputter": "error",
\       "outputter/error/success": "buffer",
\       "outputter/error/error": "quickfix",
\       "outputter/buffer/split": "botright 8sp",
\       "outputter/quickfix/open_cmd": "copen",
\       "runner": "vimproc",
\       "runner/vimproc/updatetime": "50"
\   },
\   "cpp/watchdogs_checker": { "type": "watchdogs_checker/clang++" },
\   "d/watchdogs_checker": { "type": "watchdogs_checker/dmd" },
\   "python/watchdogs_checker": { "type": "watchdogs_checker/flake8" },
\   "watchdogs_checker/clang++": { "cmdopt": "-Wall -Wextra -std=c++1z" },
\   "watchdogs_checker/dmd": { "cmdopt": "-wi -o- `~/dubimport -o`" }
\ }

let s:hook = { "name": "clear_quickfix", "kind": "hook" }

function! s:hook.on_normalized(session, context)
    call setqflist([])
endfunction

call quickrun#module#register(s:hook, 1)

unlet s:hook

" vim-watchdogs
let g:watchdogs_check_BufWritePost_enable = 1
let g:watchdogs_check_BufWritePost_enables = { "haskell": 0 }

" ghcmod-vim
autocmd BufWritePost *.hs GhcModCheckAndLintAsync

" vim-json
let g:vim_json_syntax_conceal = 0

" Ŝlosilaj mapeadoj
noremap r <C-R>

noremap n :tablast <bar> tabnew <CR>
noremap c :tabclose <CR>

noremap e :VimFilerExplorer <CR>

noremap f :Unite -buffer-name=file file <CR>
noremap t :Unite tab <CR>

noremap <C-Left> <C-W>h
noremap <C-Right> <C-W>l
noremap <C-Up> <C-W>j
noremap <C-Down> <C-W>k

noremap <S-Left> :tabprevious <CR>
noremap <S-Right> :tabnext <CR>
