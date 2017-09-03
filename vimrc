syntax on

set t_Co=256
set nobackup
set laststatus=2
set number
set cursorline
set colorcolumn=120
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%
set encoding=utf-8
set fileencodings=utf-8,sjis
set fileformats=unix,dos
set showtabline=2

function! s:SID_PREFIX()
    return matchstr(expand("<sfile>"), "<SNR>\d\+_\zeSID_PREFIX$")
endfunction

function! s:tabline()
    let s = ""

    for i in range(1, tabpagenr("$"))
        let bufnr = tabpagebuflist(i)[tabpagewinnr(i) - 1]

        let mod = getbufvar(bufnr, "&modified") ? "!" : " "
        let title = "[" . fnamemodify(bufname(bufnr), ":t") . "]"

        let s .= "%" . i . "T"
        let s .= "%#" . (i == tabpagenr() ? "TabLineSel" : "TabLine") . "#"
        let s .= i . ":" . title . mod . "%#TabLineFill# "
    endfor

    let s .= "%#TabLineFill#%T%=%#TabLine#"

    return s
endfunction

let &tabline = "%!" . s:SID_PREFIX() . "tabline()"

if has("vim_starting")
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand("~/.vim/bundle/"))

NeoBundleFetch "Shougo/neobundle.vim"

NeoBundle "Shougo/neocomplete"
NeoBundle "Shougo/neomru.vim"
NeoBundle "Shougo/neosnippet"
NeoBundle "Shougo/neosnippet-snippets"
NeoBundle "Shougo/unite.vim"
NeoBundle "Shougo/vimfiler"
NeoBundle "Shougo/vimproc.vim", { "build": { "linux": "make" } }
NeoBundle "Yggdroot/indentLine"
NeoBundle "iamcco/markdown-preview.vim"
NeoBundle "itchyny/lightline.vim"
NeoBundle "jceb/vim-hier"
NeoBundle "majutsushi/tagbar"
NeoBundle "osyo-manga/vim-watchdogs"
NeoBundle "osyo-manga/shabadou.vim"
NeoBundle "szw/vim-tags"
NeoBundle "thinca/vim-quickrun"

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

let g:unite_source_file_mru_limit = 16

let g:lightline = { "colorscheme": "solarized" }

let g:quickrun_config = {
            \ "_": {
            \   "outputter": "error",
            \   "outputter/error/success": "buffer",
            \   "outputter/error/error": "quickfix",
            \   "outputter/buffer/split": "botright 8sp",
            \   "outputter/quickfix/open_cmd": "copen",
            \   "runner": "vimproc",
            \   "runner/vimproc/updatetime": "100"
            \   },
            \
            \ "c/watchdogs_checker": { "type": "watchdogs_checker/clang" },
            \ "cpp/watchdogs_checker": { "type": "watchdogs_checker/clang++" },
            \ "d/watchdogs_checker": { "type": "watchdogs_checker/dmd" },
            \ "haskell/watchdogs_checker": { "type": "watchdogs_checker/ghc-mod" },
            \ "python/watchdogs_checker": { "type": "watchdogs_checker/flake8" },
            \
            \ "watchdogs_checker/clang": { "cmdopt": "-Wall -Wextra -std=c11 -Iinclude" },
            \ "watchdogs_checker/clang++": { "cmdopt": "-Wall -Wextra -std=c++14 -Iinclude" },
            \ "watchdogs_checker/dmd": { "cmdopt": "-wi -o- `~/bin/DUBImport/dubimport`" }
            \ }

let s:hook = { "name": "clear_quickfix", "kind": "hook" }

function! s:hook.on_normalized(session, context)
    call setqflist([])
endfunction

call quickrun#module#register(s:hook, 1)

unlet s:hook

let g:watchdogs_check_BufWritePost_enable = 1

let g:mkdp_path_to_chrome = "google-chrome-stable"

map tc :tablast <bar> tabnew<CR>
map tx :tabclose<CR>
map t1 :tabnext 1<CR>
map t2 :tabnext 2<CR>
map t3 :tabnext 3<CR>
map t4 :tabnext 4<CR>
map t5 :tabnext 5<CR>
map t6 :tabnext 6<CR>
map t7 :tabnext 7<CR>
map t8 :tabnext 8<CR>
map t9 :tabnext 9<CR>

noremap <C-Z> u
noremap <C-Y> <C-R>
noremap <C-W> <C-W>w
noremap <C-L> :TagbarToggle<CR>
noremap <C-F> :Unite -buffer-name=file file<CR>
noremap <C-H> :Unite file_mru<CR>
noremap <C-C> :UniteWithBufferDir file -buffer-name=file<CR>
noremap <C-E> :VimFilerExplorer<CR>
